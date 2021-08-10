local GuiCollisionService = {}
GuiCollisionService.__index = GuiCollisionService

local function CollidesMTV_Func(Gui_Instance1,Gui_Instance2) -- special thanks to RuizuKun_Dev
	local Gui_Instance1_Pos, Gui_Instance1_Size = Gui_Instance1.AbsolutePosition, Gui_Instance1.AbsoluteSize;
	local Gui_Instance2_Pos, Gui_Instance2_Size = Gui_Instance2.AbsolutePosition, Gui_Instance2.AbsoluteSize;
	
	local IsColliding, MTV = GuiCollisionService.isColliding(Gui_Instance1, Gui_Instance2)
	if IsColliding then
		local EdgeDifferences_Array = {
			Vector2.new(Gui_Instance1_Pos.x - (Gui_Instance2_Pos.x + Gui_Instance2_Size.x), 0);
			Vector2.new((Gui_Instance1_Pos.x + Gui_Instance1_Size.x) - Gui_Instance2_Pos.x, 0);
			Vector2.new(0, Gui_Instance1_Pos.y - (Gui_Instance2_Pos.y + Gui_Instance2_Size.y));
			Vector2.new(0, (Gui_Instance1_Pos.y + Gui_Instance1_Size.y) - Gui_Instance2_Pos.y);
		};
		table.sort(EdgeDifferences_Array, function(A, B) return A.magnitude < B.magnitude; end);
		MTV = EdgeDifferences_Array[1];
	end;
	return IsColliding, MTV or Vector2.new();
end;

local function check (hitter, colliders)
	local collidingWith = {}

	for _, collider in ipairs(colliders) do
		if collider.solid then
			local IsColliding, MTV = CollidesMTV_Func(hitter.i, collider.i);
			if IsColliding then
				if hitter.t then
					for i, tween in ipairs(hitter.t) do
						if tween.PlaybackState == Enum.PlaybackState.Playing then
							tween:Pause()
							table.remove(hitter.t, i)
						end
					end 					
				end
				hitter.i.Position = hitter.i.Position - UDim2.new(0, MTV.x, 0, MTV.y); 
			end;
		end
		
		if GuiCollisionService.isColliding(hitter.i, collider.i) then
			table.insert(collidingWith, collider.i)
		end		
	end

	if #collidingWith > 0 then
		return collidingWith
	end

	return nil
end

function GuiCollisionService.isColliding(guiObject0, guiObject1)		
	if not typeof(guiObject0) == "Instance" or not typeof(guiObject1) == "Instance" then error("argument must be an instance") return end

	local ap1 = guiObject0.AbsolutePosition
	local as1 = guiObject0.AbsoluteSize
	local sum = ap1 + as1

	local ap2 = guiObject1.AbsolutePosition
	local as2 = guiObject1.AbsoluteSize
	local sum2 = ap2 + as2

	return ((ap1.x < sum2.x and sum.x > ap2.x) and (ap1.y < sum2.y and sum.y > ap2.y))
end

function GuiCollisionService.createCollisionGroup()
	local collisionDetected = Instance.new("BindableEvent")

	local self = setmetatable({
		ColliderTouched = collisionDetected.Event
	}, GuiCollisionService)

	self.colliders = {}
	self.hitters = {}

	game:GetService("RunService").RenderStepped:Connect(function(dt)
		for _, hitter in ipairs(self.hitters) do
			local res = check(hitter, self.colliders)
			
			if res then
				local bin = {}

				for i, v in ipairs(res) do
					if table.find(bin, v) then
						table.remove(res, i)
					else
						table.insert(bin, v)
					end
				end

				hitter.i.CollidersTouched:Fire(res)
				hitter.i.Colliding.Value = true
				return
			else
				hitter.i.Colliding.Value = false
			end

			hitter.i.Colliding:GetPropertyChangedSignal("Value"):Connect(function()
				if not hitter.i.Colliding.Value then
					hitter.i.OnCollisionEnded:Fire()
					return
				end
			end)
		end		
	end)

	return self
end

function GuiCollisionService:addHitter(instance, tweens: table)
	assert(typeof(instance) == "Instance", "argument must be an instance")
	assert(typeof(tweens) == "table", "argument must be a table")

	local be = Instance.new("BindableEvent")
	be.Name = "CollidersTouched"
	be.Parent = instance

	local be2 = be:Clone()
	be2.Name = "OnCollisionEnded"
	be2.Parent = instance

	local is = Instance.new("BoolValue")
	is.Name = "Colliding"
	is.Value = false
	is.Parent = instance

	table.insert(self.hitters, { i = instance, t = tweens })
	
	return { index = #self.hitters, ["instance"] = instance }
end

function GuiCollisionService:updateHitter(i: number, instance, tweens: table)
	assert(typeof(i) == "number", "argument must be a table")
	assert(typeof(instance) == "Instance", "argument must be an instance")
	assert(typeof(tweens) == "table", "argument must be a table")
	
	self.hitters[i] = { i = instance, t = tweens or {} }
	
	return { index = i, instance = self.hitters[i].i } 
end

function GuiCollisionService:getHitter(index)
	return self.hitters[index].i
end

function GuiCollisionService:getHitterTweens(index)
	return self.hitters[index].t
end

function GuiCollisionService:getHitters()
	local res = {}

	for _, v in ipairs(self.hitters) do
		table.insert(res, v.i)
	end

	return res
end

function GuiCollisionService:removeHitter(index)
	table.remove(self.hitters, index)
end

function GuiCollisionService:addCollider(instance, t: boolean)
	assert(typeof(instance) == "Instance", "argument must be an instance")
	assert(typeof(t) == "boolean", "argument must be a boolean")

	if not self.colliders then
		self.colliders = {}
	end
	
	if t then
		table.insert(self.colliders, { i = instance, solid = true })
	else
		table.insert(self.colliders, { i = instance })
	end
	
	return { index = #self.colliders, ["instance"] = instance, solid = t }
end

function GuiCollisionService:updateCollider(i: number, instance, t: boolean)
	assert(typeof(i) == "number", "argument must be a table")
	assert(typeof(instance) == "Instance", "argument must be an instance")
	assert(typeof(t) == "boolean", "argument must be a boolean")

	self.colliders[i] = { ["i"] = instance, solid = t }

	return { index = i, instance = self.colliders[i].i, self.colliders[i].solid } 
end

function GuiCollisionService:getColliders()
	local res = {}

	for _, v in ipairs(self.colliders) do
		table.insert(res, v.i)
	end

	return res
end

function GuiCollisionService:removeCollider(index)
	table.remove(self.colliders, index)
end

return GuiCollisionService
