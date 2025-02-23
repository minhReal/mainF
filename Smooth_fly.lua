-- This is a script inspired by Govemeban800 at scriptblox, you can call this script smooth fly remake
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local flySpeed = 50
local flying = false
local bodyVelocity, bodyGyro
local flightConnection

local function initialRise(character)
    local riseSpeed = 10
    local startTime = tick()
    local riseTime = 1

    while tick() - startTime < riseTime do
        bodyVelocity.Velocity = Vector3.new(0, riseSpeed, 0)
        RunService.RenderStepped:Wait()
    end
end

local function startFlying()
    if flying then return end
    flying = true

    local character = player.Character or player.CharacterAdded:Wait()
    character.Humanoid.PlatformStand = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = character.HumanoidRootPart

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
    bodyGyro.CFrame = character.HumanoidRootPart.CFrame
    bodyGyro.Parent = character.HumanoidRootPart

    initialRise(character)

    flightConnection = RunService.RenderStepped:Connect(function()
        if flying then
            local moveDirection = character.Humanoid.MoveDirection * flySpeed
            local camLookVector = workspace.CurrentCamera.CFrame.LookVector

            if moveDirection.Magnitude > 0 then
                if camLookVector.Y > 0.2 then
                    moveDirection = moveDirection + Vector3.new(0, camLookVector.Y * flySpeed, 0)
                elseif camLookVector.Y < -0.2 then
                    moveDirection = moveDirection + Vector3.new(0, camLookVector.Y * flySpeed, 0)
                end
            else
                moveDirection = bodyVelocity.Velocity:Lerp(Vector3.new(0, 0, 0), 0.1)
            end
            
            bodyVelocity.Velocity = moveDirection

            local tiltAngle = 30
            local tiltFactor = moveDirection.Magnitude / flySpeed
            local tiltDirection = 1

            if workspace.CurrentCamera.CFrame:VectorToObjectSpace(moveDirection).Z < 0 then
                tiltDirection = -1
            end

            local tiltCFrame = CFrame.Angles(math.rad(tiltAngle) * tiltFactor * tiltDirection, 0, 0)
            local targetCFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + camLookVector) * tiltCFrame
            bodyGyro.CFrame = bodyGyro.CFrame:Lerp(targetCFrame, 0.2)
        end
    end)
end

local function stopFlying()
    if not flying then return end
    flying = false

    local character = player.Character or player.CharacterAdded:Wait()
    character.Humanoid.PlatformStand = false

    if flightConnection then
        flightConnection:Disconnect()
        flightConnection = nil
    end

    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
end

local gui = Instance.new("ScreenGui")
gui.Name = "patrickGui"
gui.Parent = CoreGui

local mainGui = Instance.new("Frame")
mainGui.Size = UDim2.new(0.25, 0, 0.1, 0)
mainGui.Position = UDim2.new(0.7, 0, 0.5, 0)
mainGui.BackgroundColor3 = Color3.new(0, 0, 0)
mainGui.BorderColor3 = Color3.new(1, 1, 1)
mainGui.BorderSizePixel = 1
mainGui.Active = true
mainGui.BackgroundTransparency = 0 
mainGui.Draggable = true
mainGui.Parent = gui
mainGui.ZIndex = 2

local GuiS = Instance.new("Frame")
GuiS.Size = UDim2.new(1, 0, 4, 0)
GuiS.Position = UDim2.new(0, 0, -0.01, 0)
GuiS.BackgroundColor3 = Color3.new(0, 0, 0)
GuiS.BorderColor3 = Color3.new(0, 0, 0)
GuiS.BorderSizePixel = 0
GuiS.Active = true
GuiS.BackgroundTransparency = 0.5
GuiS.Draggable = false
GuiS.Parent = mainGui
GuiS.ZIndex = 1

local uicornerGuiS = Instance.new("UICorner")
uicornerGuiS.CornerRadius = UDim.new(0, 30)
uicornerGuiS.Parent = GuiS

local uiStrokeGuiS = Instance.new("UIStroke")
uiStrokeGuiS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStrokeGuiS.Color = Color3.new(1, 1, 1)
uiStrokeGuiS.Thickness = 0
uiStrokeGuiS.Parent = GuiS

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
titleLabel.Position = UDim2.new(-0.1, 0, 0.325, 0)
titleLabel.BackgroundColor3 = Color3.new(0, 0, 0)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Flight Control GUI"
titleLabel.TextSize = 20
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainGui
titleLabel.ZIndex = 3

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.9, 0, 0.25, 0)
speedBox.Position = UDim2.new(0.05, 0, 0.33, 0)
speedBox.BackgroundColor3 = Color3.new(0, 0, 0)
speedBox.BorderColor3 = Color3.new(0, 0, 0)
speedBox.BorderSizePixel = 0
speedBox.PlaceholderText = "Enter speed plz"
speedBox.Text = tostring(flySpeed)
speedBox.TextSize = 20
speedBox.BackgroundTransparency = 0.5
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.Font = Enum.Font.Code
speedBox.ClearTextOnFocus = false
speedBox.Parent = GuiS

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.6, 0, 0.25, 0)
flyButton.Position = UDim2.new(0.2, 0, 0.65, 0)
flyButton.BackgroundColor3 = Color3.new(0, 0, 0)
flyButton.BorderColor3 = Color3.new(0, 0, 0)
flyButton.BorderSizePixel = 1
flyButton.Text = "Fly"
flyButton.TextSize = 20
flyButton.BackgroundTransparency = 0.5
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.Font = Enum.Font.Code
flyButton.Parent = GuiS

flyButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(speedBox.Text)
    if newSpeed then
        flySpeed = newSpeed
    end

    if flying then
        stopFlying()
        flyButton.Text = "Fly"
    else
        startFlying()
        flyButton.Text = "Fly"
        wait(0.5)
        flyButton.Text = "Fly"
    end
end)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 23, 0.1, 30) 
closeButton.Position = UDim2.new(0.85, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.BackgroundTransparency = 1
closeButton.Parent = mainGui
closeButton.ZIndex = 3
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
