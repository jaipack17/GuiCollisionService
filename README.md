<div align="center">
    <a href="https://www.roblox.com/library/7145661386/GuiCollisionService"><img style="left:70" src="https://raw.githubusercontent.com/jaipack17/GuiCollisionService/main/GuiCollision-removebg-preview%20(1).png" width="606" alt="logo" /></a>
<br/>
    <a href="https://www.roblox.com/library/7145661386/GuiCollisionService">
      <img src="https://img.shields.io/badge/module-get-blue"/>
    </a>
    <a href="https://github.com/jaipack17/GuiCollisionService/blob/main/CONTRIBUTING.md"><img src="https://img.shields.io/badge/github-contribute-black" alt="contribute" /></a>
    <a href="https://www.github.com/jaipack17/GuiCollisionService/issues"><img src="https://img.shields.io/badge/issues-bugs-red" alt="issues" /></a>
    <a href="https://github.com/jaipack17/cli-pages#documentation"><img src="https://img.shields.io/badge/docs-view-%23blue" alt="docs" /></a>
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


### Game made using this module
https://www.roblox.com/games/7111031857/Flappy-Wings

<hr/>

# -- [ Navigation ] --

# [Module](https://www.roblox.com/library/7145661386/GuiCollisionService)

# [Bug Reporting](https://www.github.com/jaipack17/GuiCollisionService/issues)

# [Contributing](https://github.com/jaipack17/GuiCollisionService/blob/main/CONTRIBUTING.md)

<hr/>

# Documentation

## `.createCollisionGroup()`

This function is the first step out of all, in order to create your colliders and hits.

* parameters: none
* returns: metatable

```lua
local GuiCollisionService = require(game.ReplicatedStorage.GuiCollisionService)

local group = GuiCollisionService.createCollisionGroup()
```

## `.isColliding`

* parameters: guiObjectHitter: instance, guiObjectCollider: instance
* returns: boolean

```lua
local instance1 = script.Parent.Frame1 -- example
local instance2 = script.Parent.Collider -- example [Frame]

group.isColliding(instance1, instance2)
```

#### Thank you, Hope it helps you out, I would love to see the growth of 2 Dimensional games on roblox, and thats why I am bringing out a **tutorial** for making 2 dimensional roblox games pretty soon! 

**Peace!**
