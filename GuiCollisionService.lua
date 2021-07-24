local GuiCollisionService = {}
GuiCollisionService.__index = GuiCollisionService

local function check (hitter, colliders)
	local collidingWith = {}
	
	for _, collider in ipairs(colliders) do
		if GuiCollisionService.isColliding(hitter, collider) then
			table.insert(collidingWith, collider)
		end
	end
	
	if #collidingWith > 0 then
		return collidingWith
	end
	
	return nil
end

function GuiCollisionService.isColliding(guiObject0, guiObject1)	
	if not guiObject0 or not guiObject1 then
		return;
	end
	
	if not typeof(guiObject0) == "Instance" or not typeof(guiObject1) == "Instance" then error("argument must be an instance") return end
	
	local ap0 = guiObject0.AbsolutePosition
	local ap1 = guiObject1.AbsolutePosition
	local as0 = guiObject0.AbsoluteSize
	local as1 = guiObject1.AbsoluteSize
	
	if ap0 and ap1 then
		local ap0as0 = ap0 + as0
		local ap1as1 = ap1 + as1
		return (ap0.X < ap1as1.X and ap1as1.X > ap1.X) and (ap0.Y < ap1as1.Y and ap0as0.Y > ap1.Y)
	end
end

function GuiCollisionService.createCollisionGroup()
	local collisionDetected = Instance.new("BindableEvent")
	
	local self = setmetatable({
		ColliderTouched = collisionDetected.Event
	}, GuiCollisionService)
	
	self.colliders = {}
	self.hitters = {}
	
	game:GetService("RunService").RenderStepped:Connect(function()
		for _, hitter in ipairs(self.hitters) do
			local res = check(hitter, self.colliders)
			if res then
				hitter.CollidersTouched:Fire(res)
			else
				hitter.OnCollisionEnded:Fire()
			end
		end
	end)

	return self
end

function GuiCollisionService:addHitter(instance)
	if not typeof(instance) == "Instance" then error("argument must be an instance") return end
	
	local be = Instance.new("BindableEvent")
	be.Name = "CollidersTouched"
	be.Parent = instance
	
	local be2 = be:Clone()
	be2.Parent = instance
	be2.Name = "OnCollisionEnded"
	
	table.insert(self.hitters, instance)
end

function GuiCollisionService:getHitter(index)
	return self.hitters[index]
end

function GuiCollisionService:getHitters()
	return self.hitters
end

function GuiCollisionService:removeHitter(index)
	table.remove(self.hitters, index)
end

function GuiCollisionService:addCollider(instance)
	if not typeof(instance) == "Instance" then error("argument must be an instance") return end

	if not self.colliders then
		self.colliders = {}
	end
	
	table.insert(self.colliders, instance)
end

function GuiCollisionService:getColliders()
	return self.colliders
end

function GuiCollisionService:removeCollider(index)
	table.remove(self.colliders, index)
end

return GuiCollisionService
