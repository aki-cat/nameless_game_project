-- ElementList



function ElementList( self )

	local function newPlayer()

		local element = Element({}, 'player')

		-- create body property
		local body = Body( {}, element )
		-- add body events: MovementInput, Collision, ...
		body:addEvent( Body_MovementInput({}, body) )
		body:addEvent( Body_Collision({}, body) )
		-- add body to element
		element:addProperty( body )

		-- create sprite property
		local sprite = Sprite( {}, element, 'avatar', 4, 4 )
		-- add sprite events: MovementInput, ...
		sprite:addEvent( Sprite_MovementInput({}, sprite) )
		-- add sprite to element
		element:addProperty( sprite )

		return element
	end

	local function newCamera()

		local element = Camera({}, 'camera')

		local body = Body({}, self )
		body:addEvent( Body_MovementInput({}, body ) )
		body:addEvent( Body_Collision({}, body ) )
		self:addProperty( body )

		self:addProperty( Translate({}, self ) )

		return element
	end

	local function newNPC(name)

		local element = Element({}, 'player')

		-- create body property
		local body = Body( {}, element )
		-- add body events: Collision, ...
		body:addEvent( Body_Collision({}, body) )
		-- add body to element
		element:addProperty( body )

		-- create sprite property
		local sprite = Sprite ( {}, element, name or 'NPC', 1, 1 )
		-- add sprite to element
		element:addProperty( sprite )

		return element
	end

	function self:addElement(element)
		self[element:getId()] = element
	end

	function self:newElement( type, name )
		local element
		if type == 'player' then
			element = newPlayer()
		end
		if type == 'camera' then
			element = newCamera()
		end
		if type == 'npc' then
			element = newNPC(name)
		end
		if not type == 'camera' then self:addElement(element) end
		return element
	end

	return self
end