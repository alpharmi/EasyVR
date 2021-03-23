# EasyVR

EasyVR is a Lua module that allows developers to VR functionality within their game simply without having to program the backend to get VR working. This module gives simple and advanced functionality thats completly customisable and user friendly.

# Contents
* [Example](#Example)
* [Documentation](#Docuementation)
* [Source](#Source)
* [Credits](#Credits)

# Example

```
local User = require(script:WaitForChild("EasyVR")) --Require the module

local TestHat = game.Workspace:WaitForChild("ValkyrieHelm")

User.Create() --Create head and hands
User.AttachInstance("Head", TestHat) --Attach a instance to User (Part, Union, MeshPart or Model)
User.Run() --Run User (Hand movement and Head movement, etc)

User.ButtonPressed(function(Button) --Click a button on the controllers
	if Button == Enum.KeyCode.ButtonX then
		print("Button Pressed")
	end
end)
User.ButtonReleased(function(Button) --Release a button on the controllers
	if Button == Enum.KeyCode.ButtonX then
		print("Button Released")
	end
end)
User.SetMovementAxis("Gloabl") --What axis the User moves on
User.SetThumbstickMovement(false) --Disable User movement by thumbstick
User.ThumbstickMoved(function(Thumbstick, X, Y) --Return thumbstick and x, y positions when moved.
	print(Thumbstick, X, Y)
end)

User.DebugMode(true) --Turns on debug mode (Allows you to see hands)
User.DisableUI() --Disable Core GUI / VR UI (Pointers, Teleporter, etc)
```

# Documentation

```User.Create()``` Creates a VR User that includes Head, LeftHand and RightHand
