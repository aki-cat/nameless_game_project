-- Main --

require 'input'

require 'Element/Element'
require 'Element/Elements/Camera'

require 'Property/Property'
require 'Property/Properties/Sprite'
require 'Property/Properties/HitBox'
require 'Property/Properties/Body'
require 'Property/Properties/Translate'

require 'Event/Event'
require 'Event/Events/Sprite_MovementInput'
require 'Event/Events/Body_MovementInput'
require 'Event/Events/Body_Collision'

local dtotal = 0
local fps = 1/30

input = input( {} )
elements = {}
camera = {}

unit = 16
zoom = 2

function love.load()
	-- load things
	window = love.graphics.newCanvas(1280,720)
	love.graphics.setBackgroundColor(0, 0, 0)
	
	local player = newElement('player')
	local jeff = newElement('npc', 'jeff')
	player:getProperty('Body'):setPos( 48, 32 )
	jeff:getProperty('Body'):setPos( 24, 32 )

	elements[jeff:getId()] = jeff
	elements[player:getId()] = player

	camera = newElement('camera')

end

function love.update( dt )
	dtotal = dtotal + dt
	while dtotal >= fps do
		dtotal = dtotal - fps

		-- do things here

		input:update()
		camera:update()

		for _,element in pairs(elements) do
			if element:getProperty('Body') then
				element:getProperty('Body'):update()
			end
			if element:getProperty('Sprite') then
				element:getProperty('Sprite'):update()
			end
		end
	end
end

function love.draw()
	
	-- render things

	camera:render()
	
	for _,element in pairs(elements) do
		if element:getProperty('Sprite') then
			element:getProperty('Sprite'):render()
		end
	end
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end

function newElement( type, name )
	local element = Element({}, name or type)

	if type == 'player' then
		
		-- adding properties
		element:addProperty( HitBox ( {}, element ) )
		local sprite = Sprite( {}, element, 'avatar', 4, 4 )
		local body = Body( {}, element )

		sprite:addEvent( Sprite_MovementInput({}, sprite) )

		body:addEvent( Body_MovementInput({}, body) )
		body:addEvent( Body_Collision({}, body) )

		element:addProperty( sprite )
		element:addProperty( body )

		-- setting properties
		local w = element:getAttribute( 'Sprite', 'QuadWidth' )
		local h = element:getAttribute( 'Sprite', 'QuadHeight' )
		element:setAttribute( 'HitBox', 'Width', w-16 )
		element:setAttribute( 'HitBox', 'Height', h-8 )

	end
	if type == 'npc' then
		
		element:addProperty( Sprite ( {}, element, name or type, 1, 1 ) )
		element:addProperty( HitBox ( {}, element ) )
		element:addProperty( Body ( {}, element ) )

	end
	if type == 'camera' then
		element = Camera({}, 'camera')
	end

	return element
end
