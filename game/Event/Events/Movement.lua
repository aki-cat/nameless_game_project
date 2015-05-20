-- Movement --

function Movement( self, move, element )
	Event(self)

	local body = element:getProperty('Body')
	local sprite = element:getProperty('Sprite')

	-- calculate movement polar coordinate
	local function getAngle()
		local angle
		local v = Vector2D()
		--local move = input:getMovement()

		if move then
			if move.l then
				v.x = -1
			end
			if move.r then
				v.x = 1
			end
			if move.u then
				v.y = -1
			end
			if move.d then
				v.y = 1
			end
			angle = math.atan2(v.y, v.x)
			return angle
		else
			return
		end
	end
	local function setSpriteState()
		if move then
			if move.l then
				sprite:setState('walk','left')
			elseif move.r then
				sprite:setState('walk','right')
			else
				sprite:setState('walk')
			end
		else
			sprite:setState('still')
		end
	end
	
	-- update method
	function self:happen()
		local angle = getAngle()
		if angle then
			body:move(angle)
		else
			body:stop()
		end
		setSpriteState()
	end

	return self
end