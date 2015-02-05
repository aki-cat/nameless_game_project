-- ElementList



function ElementList( self )
	
	local elist = {}

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

		local body = Body({}, element )
		body:addEvent( Body_MovementInput({}, body ) )
		body:addEvent( Body_Collision({}, body ) )
		element:addProperty( body )

		element:addProperty( Translate({}, element ) )

		return element
	end

	local function newNPC(name)

		local element = Element({}, name)

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
		local name = element:getId()
		print(name)
		elist[name] = element
	end
	function self:getElement(elementname)
		return elist[elementname]
	end
	function self:getElist()
		return elist
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
		self:addElement(element)
		return element
	end

	return self
end