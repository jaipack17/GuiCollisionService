<div align="center">
    <a href="https://www.roblox.com/library/7145661386/GuiCollisionService"><img style="left:70" src="https://raw.githubusercontent.com/jaipack17/GuiCollisionService/main/GuiCollision-removebg-preview%20(1).png" width="606" alt="logo" /></a>
<br/>
    <a href="https://www.roblox.com/library/7145661386/GuiCollisionService">
      <img src="https://img.shields.io/badge/module-get-blue"/>
    </a>
    <a href="https://www.roblox.com/library/7145661386/GuiCollisionService">
      <img src="https://img.shields.io/badge/version-3.0-yellow"/>
    </a>
    <a href="https://github.com/jaipack17/GuiCollisionService/blob/main/CONTRIBUTING.md"><img src="https://img.shields.io/badge/github-contribute-black" alt="contribute" /></a>
    <a href="https://www.github.com/jaipack17/GuiCollisionService/issues"><img src="https://img.shields.io/badge/issues-bugs-red" alt="issues" /></a>
</div>

<hr/>

**Table of Contents**
- [About](#about)
- [Getting Started](#getting-started)
- [Initializing](#initializing)
- [Examples](#examples)
- [Navigation](#----navigation----)
- [Documentation](#documentation)

# About

[GuiCollisionService](https://www.roblox.com/library/7145661386/GuiCollisionService) is an easy to use module that focuses on helping you create collidable Guis and help you detect them using BindableEvents. It is one of the easiest and efficient Gui Collision Detector out there. It helps you to create intuative 2 dimensional physics in your roblox games.

# Getting Started

- Get the module through this link: https://www.roblox.com/library/7145661386/GuiCollisionService
- Place the module inside ReplicatedStorage<br/>![image](https://user-images.githubusercontent.com/74130881/126872432-fbe0643b-fb8a-4377-afab-77d14bb4a052.png)


# Initializing
Require the module in a LocalScript or a Script using the following code - 
```lua
local GuiCollisionService = require(game:GetService("ReplicatedStorage").GuiCollisionService)
```

# Examples
### Destroying targets when touched
![5a696aecff47ff4165895e529446fea3ab3f6485](https://user-images.githubusercontent.com/74130881/126872487-9656af92-deb9-4d1b-9781-3866fc1f19c0.gif)

### Changing colors on collision [Video quality issue]
![4fedc03f47fd67953bb40e363b84eb385fb42a10](https://user-images.githubusercontent.com/74130881/126872485-260f5a83-6399-4d57-be87-ac234d861b37.gif)

### Solid Colliding Gui Frames

![new ??? Made with Clipchamp](https://user-images.githubusercontent.com/74130881/128133416-07fee16d-e37a-476e-9e8a-f71569b85109.gif)


### Game made using this module
https://www.roblox.com/games/7111031857/Flappy-Wings

<hr/>

# -- [ Navigation ] --

# [Module](https://www.roblox.com/library/7145661386/GuiCollisionService)

# [Bug Reporting](https://www.github.com/jaipack17/GuiCollisionService/issues)

# [Contributing](https://github.com/jaipack17/GuiCollisionService/blob/main/CONTRIBUTING.md)

<hr/>

# Documentation

Before diving into the documentation, I would like to tell you, this module works on the basis of the 'hitter n collider' principle

![image](https://user-images.githubusercontent.com/74130881/126873329-870a2c2a-e1cd-4673-95d1-e2195c034f54.png)

The white frame is the collider - It is the frame that is hit by the hitter
The green frame is the hitter - It is the frame that collides with the collider

**Initializing**

## `.createCollisionGroup()`

This function is the first step out of all, in order to create your colliders and hits.

* parameters: none
* returns: metatable

```lua
local GuiCollisionService = require(game.ReplicatedStorage.GuiCollisionService)

local group = GuiCollisionService.createCollisionGroup()
```
<hr/>

**Raw**

## `.isColliding()`

* parameters: guiObjectHitter: instance, guiObjectCollider: instance
* returns: boolean

```lua
local instance1 = script.Parent.Frame1 -- example
local instance2 = script.Parent.Collider -- example [Frame]

GuiCollisionService.isColliding(instance1, instance2)
```

## `.isInCore()`

* parameters: guiObjectHitter: instance, guiObjectCollider: instance
* returns: boolean

This function returns true if a gui is completely inside of another, else it returns false. If guiHitter's size is smaller than that of guiCollider, the function returns false.

```lua
local instance1 = script.Parent.Frame1 -- example
local instance2 = script.Parent.Collider -- example [Frame]

GuiCollisionService.isInCore(instance1, instance2)
```

<hr/>

## `setZIndexHierarchy()`

* parameters: shouldCollideAccordingToZIndex: boolean
* returns: nil

The function is used to determine if the hitter will collide with colliders that have different ZIndex values. 

By default it is set to false

```lua
group:setZIndexHierarchy(true) -- hitter won't collide with colliders that have different Zindex values than the hitter
```

```lua
group:setZIndexHierarchy(false) -- hitter will collide with colliders that have different Zindex values than the hitter and also the colliders that have the same ZIndex as the hitter
```

**Managing Colliders**

## `addCollider()`

* parameters: guiObjectCollider: instance, solid: boolean
* returns: { index: number, instance: instance, solid: boolean }

The following function is used to declare a gui instance as a collider. Whenever a hitter collides with this gui instance, an event will be fired.

```lua
group:addCollider(script.Parent.Still)
group:addCollider(script.Parent.Frame)
local collider = group:addCollider(script.Parent.Frame2)
group:addCollider(script.Parent.Frame3, true) -- To make it impossible for a hitter to go through the collider

--[[
Colliders are saved as such:
 {
   Still,
   Frame, 
   Frame2,
   Frame3
 }
]]--
```

## `updateCollider()`

* parameters: index: number, instance: instance, solid: boolean
* returns: hitter: { index: number, instance: instance, solid: boolean }

This updates already existing collider's instance and solid property!

```lua
group:updateCollider(2, script.Parent.someCollider, false)
```

## `getColliders()`

* parameters: none
* returns: table

```lua
print(group:getColliders())
```

## `removeCollider()`

* parameters: index: number
* returns: nil

```lua
group:removeCollider(1) -- removes the 1st collider that was added
```
<hr/>

**Managing Hitters**
## `addHitter()`

* parameters: guiObject: instance, tweens: table
* returns: hitter: { index: number, hitterInstance: instance }

```lua
local tween = game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(1, Enum.EasingStyle.Linear), {Position = UDim2.new(1,0,.5,0)})
group:addHitter(script.Parent.HitFrame, { tween })
```

## `updateHitter()`

* parameters: index: number, instance: instance, tweens: table
* returns: hitter: { index: number, hitterInstance: instance }

This updates already existing hitter's instance and tweens!

```lua
group:updateHitter(1, script.Parent.SomeFrame, { tween1, tween2, tween3 })
```

## `getHitter()`

* parameters: index: number
* returns: instance

```lua
group:getHitter(1) -- returns the first hitter added
```

## `getHitters()`

* parameters: none
* returns: table

```lua
group:getHitters()
```

## `getHitterTweens()`

* parameters: index: number
* returns: tweens: table

Returns all the tweens of the hitter

```lua
group:getHitterTweens(1) -- returns tweens of the 1st hitter
```

## `removeHitter()`

* parameters: index: number
* returns: nil

```lua
group:removeHitter(1) -- removes the first hitter added
```
<hr/>

**Managing Events**

## `CollidersTouched - Event`
This event is fired when a hitter touches a collider! If it does, it returns a table of the colliders it is touching with

```lua
local hitter = group:getHitter(1) -- first hitter

hitter.CollidersTouched.Event:Connect(function(hits)
   hitter.BackgroundColor3 = Color3.new(255,0,0) -- changes color of hitter to red when it collides.
end)
```

## `OnCollisionEnded - Event`
This event is fired when a hitter is not in touch with any colliders at all

```lua
local hitter = group:getHitter(1) -- first hitter

hitter.OnCollisionEnded.Event:Connect(function(hits)
   hitter.BackgroundColor3 = Color3.new(0,0,0) -- changes color of hitter to white
end)
```

## Example Code

StarterGui:<br/>![image](https://user-images.githubusercontent.com/74130881/126873058-25393536-c6a8-4789-859b-20a02bedfd65.png)

Place a localscript inside ScreenGui: 
```lua
local GuiCollisionService = require(game.ReplicatedStorage.GuiCollisionService)

local group = GuiCollisionService.createCollisionGroup()

group:addCollider(script.Parent.Still)
group:addCollider(script.Parent.Still2)
group:addCollider(script.Parent.Still3)
group:addHitter(script.Parent.Move)

group:getHitter(1).CollidersTouched.Event:Connect(function(hits)
	group:getHitter(1).BackgroundColor3 = Color3.new(0.333333, 1, 0)
end)

group:getHitter(1).OnCollisionEnded.Event:Connect(function()
	group:getHitter(1).BackgroundColor3 = Color3.new(255,255,255)
end)
```

Place a localscript inside Move: 

```lua
local player = game.Players.LocalPlayer
local RS = game:GetService("RunService")

RS.RenderStepped:Connect(function()
	script.Parent.Position = UDim2.new(0, player:GetMouse().X, 0, player:GetMouse().Y)
end)

```

<hr/>

#### Thank you, Hope it helps you out, I would love to see the growth of 2 Dimensional games on roblox, and thats why I am bringing out a **tutorial** for making 2 dimensional roblox games pretty soon! 

**Peace!**
