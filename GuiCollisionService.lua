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
	
	return (guiObject0.AbsolutePosition.X < (guiObject1.AbsolutePosition + guiObject1.AbsoluteSize).X and (guiObject0.AbsolutePosition + guiObject0.AbsoluteSize).X > guiObject1.AbsolutePosition.X) and (guiObject0.AbsolutePosition.Y < (guiObject1.AbsolutePosition + guiObject1.AbsoluteSize).Y and (guiObject0.AbsolutePosition + guiObject0.AbsoluteSize).Y > guiObject1.AbsolutePosition.Y) 
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
