--Services

local VRService = game:GetService("VRService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HapticService = game:GetService("HapticService")

--Variables

local VR = {}
local User = nil

local Camera = game.Workspace.CurrentCamera

local Running = false
local HandDistance = 1
local WalkSpeed = 2
local ThumstickMovement = true
local MovementAxis = "Relative"
local MovementDirection = Vector3.new(0, 0, 0)


--Functions
VR.Run = function()
	Running = true
end
VR.Stop = function()
	Running = false
end
VR.SetHandDistance = function(Float)
	HandDistance = Float
end
VR.SetWalkSpeed = function(Float)
	WalkSpeed = Float
end
VR.SetThumbstickMovement = function(Bool)
	ThumstickMovement = Bool
end
VR.SetMovementAxis = function(String)
	if String == "World" then
		MovementAxis = String
	elseif String == "Relative" then
		MovementAxis = String
	else
		return print("Invalid movement aixs.")
	end
end
VR.Rumble = function(Hand, Amount, Time)
	if Hand == "LeftHand" then
		HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.LeftHand, Amount)
		wait(Time)
		HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.LeftHand, 0)
	elseif Hand == "RightHand" then
		HapticService:SetMotor(Enum.UserInputType.Gamepad2, Enum.VibrationMotor.RightHand, Amount)
		wait(Time)
		HapticService:SetMotor(Enum.UserInputType.Gamepad2, Enum.VibrationMotor.RightHand, 0)
	end
end
VR.AttachInstance = function(Part, RequestedInstance, Offset)
	local UserPart = nil
	for i, v in pairs(User:GetChildren()) do
		if v.Name == Part then
			UserPart = v
		end
	end
	if UserPart ~= nil then
		if RequestedInstance:IsA("Part") or RequestedInstance:IsA("UnionOperation") or RequestedInstance:IsA("MeshPart") then
			local Part = RequestedInstance
			local Weld = Instance.new("Weld")
			Weld.Name = "VRWeld" --I could use a function to make welds to make it more neat.
			Weld.Parent = Part
			Weld.Part0 = Part
			Weld.Part1 = UserPart
			if Offset ~= nil then
				Weld.C0 = Offset
			end
			Part.Anchored = false
		elseif RequestedInstance:IsA("Model") then
			local Model = RequestedInstance
			for i, Part in pairs(Model:GetChildren()) do
				pcall(function()
					Part.Anchored = true
					local ModelVRWeld = Instance.new("WeldConstraint")
					ModelVRWeld.Name = "VRWeld"
					ModelVRWeld.Parent = Part
					ModelVRWeld.Part0 = Part
					ModelVRWeld.Part1 = Model.PrimaryPart
					Part.Anchored = false
				end) 
			end
			local Weld = Instance.new("Weld")
			Weld.Name = "VRWeld"
			Weld.Parent = Model.PrimaryPart
			Weld.Part0 = Model.PrimaryPart
			Weld.Part1 = UserPart
			if Offset ~= nil then
				Weld.C0 = Offset
			end
		elseif RequestedInstance:IsA("Accessory") then
			local Handle = RequestedInstance:FindFirstChildOfClass("Part")
			local Weld = Instance.new("Weld")
			Weld.Name = "VRWeld"
			Weld.Parent = Handle
			Weld.Part0 = Handle
			Weld.Part1 = UserPart
			if Offset ~= nil then
				Weld.C0 = Offset
			end
			Handle.Anchored = false
		end
	else
		return error(Part.Name.. " is not a valid limb.")
	end
end
VR.Create = function()
	if game.Workspace:FindFirstChild("User") then
		return error("A user already exists.")
	else
		User = Instance.new("Folder")
		User.Name = "User"
		User.Parent = game.Workspace
		local Head = Instance.new("Part")
		Head.Name = "Head"
		Head.Parent = User
		Head.Anchored = true
		Head.Size = Vector3.new(1, 1, 1)
		Head.Transparency = 1
		local LeftHand = Instance.new("Part")
		LeftHand.Name = "LeftHand"
		LeftHand.Parent = User
		LeftHand.Anchored = true
		LeftHand.Size = Vector3.new(1, 1, 1)
		LeftHand.Transparency = 1
		local RightHand = Instance.new("Part")
		RightHand.Name = "RightHand"
		RightHand.Parent = User
		RightHand.Anchored = true
		RightHand.Size = Vector3.new(1, 1, 1)
		RightHand.Transparency = 1
	end
end
VR.ButtonPressed = function(PassedFunction)
	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if not GameProcessed then
			PassedFunction(Input.KeyCode)
		end
	end)
end
VR.ButtonReleased = function(PassedFunction)
	UserInputService.InputEnded:Connect(function(Input, GameProcessed)
		if not GameProcessed then
			PassedFunction(Input.KeyCode)
		end
	end)
end
VR.ThumbstickMoved = function(PassedFunction)
	UserInputService.InputChanged:Connect(function(Input, GameProcessed)
		if Input.KeyCode == Enum.KeyCode.Thumbstick1 then
			PassedFunction(Enum.KeyCode.Thumbstick1, Input.Position.X, Input.Position.Y)
		elseif Input.KeyCode == Enum.KeyCode.Thumbstick2 then
			PassedFunction(Enum.KeyCode.Thumbstick2, Input.Position.X, Input.Position.Y)
		end
	end)
end
VR.DebugMode = function(Bool)
	for i, User in pairs(game.Workspace:GetChildren()) do
		if User.Name:match("User") then
			if Bool then
				User.LeftHand.Color = Color3.fromRGB(255, 0, 0)
				User.RightHand.Color = Color3.fromRGB(0, 0, 255)
				User.LeftHand.Transparency = 0.2
				User.RightHand.Transparency = 0.2
			else
				User.LeftHand.Color = Color3.fromRGB(163, 162, 165)
				User.RightHand.Color = Color3.fromRGB(163, 162, 165)
				User.LeftHand.Transparency = 1
				User.RightHand.Transparency = 1
			end
		end
	end
end
VR.DisableUI = function()
	game.StarterGui:SetCore("VRLaserPointerMode", 0)
	game.StarterGui:SetCore("VREnableControllerModels", false)
end

--Runtime

RunService.RenderStepped:Connect(function()
	if Running then
		local HeadCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)
		User.Head.CFrame = CFrame.new(User.Head.Position + MovementDirection) * CFrame.Angles(HeadCFrame:ToOrientation())
		local LeftHandCFrame = User.Head.CFrame * VRService:GetUserCFrame(Enum.UserCFrame.LeftHand)
		local RightHandCFrame = User.Head.CFrame * VRService:GetUserCFrame(Enum.UserCFrame.RightHand)
		Camera.CFrame = User.Head.CFrame
		User.LeftHand.CFrame = LeftHandCFrame + (LeftHandCFrame.lookVector * HandDistance)
		User.RightHand.CFrame = RightHandCFrame + (RightHandCFrame.lookVector * HandDistance)
	end
end)

UserInputService.InputChanged:Connect(function(Input, GameProcessed)
	if ThumstickMovement then
		if Input.KeyCode == Enum.KeyCode.Thumbstick1 then
			if MovementAxis == "World" then
				MovementDirection = Vector3.new(Input.Position.X, Input.Position.Y, Input.Position.X) * WalkSpeed / 10
			else
				local MovementDirectionMath = (Input.Position.X * User.Head.CFrame.rightVector  / WalkSpeed) + (Input.Position.Y * User.Head.CFrame.lookVector  / WalkSpeed)  --Math by Arcental
				MovementDirection = -(Vector3.new(MovementDirectionMath.X, User.Head.Position.Y, MovementDirectionMath.Z))
			end
		end
	end
end)

return VR
