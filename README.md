# EasyVR

EasyVR is a Lua module that allows developers to VR functionality within their game simply without having to program the backend to get VR working. This module gives simple and advanced functionality thats completly customisable and user friendly.

# Contents
* [Example](#Example)
* [Documentation](#Documentation)
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

```User.Create()``` Creates the VR User that includes Head, LeftHand and RightHand

```User.Run()``` Runs the VR User. Enables the ability to look around and move hands.

```User.Stop()``` Stops the VR User. Disabled the ability to look around and move hands.


```User.SetHandDistance(Float)``` Sets the hand distance (in studs) away from the head.

```User.SetWalkSpeed(Float)``` Sets the WalkSpeed of the User.

```User.SetThumbstickMovement(Bool)``` Enables or disables the ability to move with the left thumbstick.

```User.SetMovementAxis(String <World> <Relative>)``` Which axis to move by. Example <World> is like flying around in VR.
	
```
User.ButtonReleased(function(Button) --Release a button on the controllers
	if Button == Enum.KeyCode.ButtonX then
		print("Button Released")
	end
end)
```Enables or disables the ability to move with the left thumbstick.
