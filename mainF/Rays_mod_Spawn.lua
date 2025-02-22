-- By Hydro_gen --
local gui = Instance.new("ScreenGui")
gui.Name = "Hi"
gui.Parent = game.CoreGui

local main1 = Instance.new("Frame")
main1.Size = UDim2.new(0.3, 0, 0.09, 0)
main1.Position = UDim2.new(0.6, 0, 0.45, 0)
main1.BackgroundColor3 = Color3.new(0, 0, 0)
main1.BorderColor3 = Color3.new(0, 0, 0)
main1.BorderSizePixel = 0
main1.Active = true
main1.ZIndex = 2
main1.BackgroundTransparency = 0 
main1.Draggable = true
main1.Parent = gui

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0.1, 0, -1, 0)
Close.Position = UDim2.new(0.9, 0, 1, 0)
Close.BackgroundColor3 = Color3.new(255, 0, 0)
Close.BorderColor3 = Color3.new(0, 0, 0)
Close.BorderSizePixel = 0
Close.Text = "X"
Close.TextSize = 20
Close.ZIndex = 2
Close.BackgroundTransparency = 1
Close.TextColor3 = Color3.new(255, 255, 255)
Close.Font = Enum.Font.Code
Close.Parent = main1

local Hide = Instance.new("TextButton")
Hide.Size = UDim2.new(0.1, 0, -1, 0)
Hide.Position = UDim2.new(0.8, 0, 1, 0)
Hide.BackgroundColor3 = Color3.new(0, 0, 255)
Hide.BorderColor3 = Color3.new(0, 0, 0)
Hide.BorderSizePixel = 0
Hide.Text = "-"
Hide.TextSize = 20
Hide.ZIndex = 2
Hide.BackgroundTransparency = 1
Hide.TextColor3 = Color3.new(255, 255, 255)
Hide.Font = Enum.Font.Code
Hide.Parent = main1

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(0.3, 0, 0.5, 0)
Label.Position = UDim2.new(0.23, 0, 0.2, 0)
Label.BackgroundColor3 = Color3.new(0, 0, 0)
Label.BorderColor3 = Color3.new(0, 0, 0)
Label.BorderSizePixel = 1
Label.Text = "Spawn item and object"
Label.ZIndex = 3
Label.TextSize = 17
Label.BackgroundTransparency = 1
Label.TextColor3 = Color3.new(255, 255, 255)
Label.Font = Enum.Font.Code
Label.Parent = main1

local main2 = Instance.new("Frame")
main2.Size = UDim2.new(0.996, 0, 4, 0)
main2.Position = UDim2.new(0, 0, 0.2, 0)
main2.BackgroundColor3 = Color3.new(0, 0, 0)
main2.BorderColor3 = Color3.new(0, 0, 0)
main2.BorderSizePixel = 1
main2.Active = true
main2.ZIndex = 1
main2.BackgroundTransparency = 0.5
main2.Draggable = false
main2.Parent = main1

local Items = Instance.new("TextBox")
Items.Size = UDim2.new(0.8, 0, 0.25, 0)
Items.Position = UDim2.new(0.03, 0, 0.3, 0)
Items.BackgroundColor3 = Color3.new(217/255, 217/255, 217/255)
Items.BorderColor3 = Color3.new(0, 0, 0)
Items.BorderSizePixel = 1
Items.Text = "items"
Items.TextColor3 = Color3.new(255, 255, 255)
Items.BackgroundTransparency = 0.5
Items.Font = Enum.Font.Code
Items.TextSize = 15
Items.Parent = main2

local Spawn_item = Instance.new("TextButton")
Spawn_item.Size = UDim2.new(0.15, 0, 0.25, 0)
Spawn_item.Position = UDim2.new(0.845, 0, 0.3, 0)
Spawn_item.BackgroundColor3 = Color3.new(217/255, 217/255, 217/255)
Spawn_item.BorderColor3 = Color3.new(0, 0, 0)
Spawn_item.BorderSizePixel = 1
Spawn_item.Text = ">"
Spawn_item.TextSize = 20
Spawn_item.BackgroundTransparency = 0.2
Spawn_item.TextColor3 = Color3.new(255, 255, 255)
Spawn_item.Font = Enum.Font.Code
Spawn_item.Parent = main2

local Object = Instance.new("TextBox")
Object.Size = UDim2.new(0.8, 0, 0.25, 0)
Object.Position = UDim2.new(0.03, 0, 0.65, 0)
Object.BackgroundColor3 = Color3.new(217/255, 217/255, 217/255)
Object.BorderColor3 = Color3.new(0, 0, 0)
Object.BorderSizePixel = 1
Object.Text = "Object"
Object.TextColor3 = Color3.new(255, 255, 255)
Object.BackgroundTransparency = 0.5
Object.Font = Enum.Font.Code
Object.TextSize = 15
Object.Parent = main2

local Spawn_Obj = Instance.new("TextButton")
Spawn_Obj.Size = UDim2.new(0.15, 0, 0.25, 0)
Spawn_Obj.Position = UDim2.new(0.845, 0, 0.65, 0)
Spawn_Obj.BackgroundColor3 = Color3.new(217/255, 217/255, 217/255)
Spawn_Obj.BorderColor3 = Color3.new(0, 0, 0)
Spawn_Obj.BorderSizePixel = 1
Spawn_Obj.Text = ">"
Spawn_Obj.TextSize = 20
Spawn_Obj.BackgroundTransparency = 0.2
Spawn_Obj.TextColor3 = Color3.new(255, 255, 255)
Spawn_Obj.Font = Enum.Font.Code
Spawn_Obj.Parent = main2

-- Các chức năng cho nút Close và Hide
Close.MouseButton1Click:Connect(function()
    main1:Destroy()
end)

Hide.MouseButton1Click:Connect(function()
    main2.Visible = not main2.Visible
end)

-- Kết nối sự kiện cho nút Spawn_item
Spawn_item.MouseButton1Click:Connect(function()
    local itemName = Items.Text
    game:GetService("ReplicatedStorage").WeaponEvent:FireServer(itemName)
end)

-- Kết nối sự kiện cho nút Spawn_Obj
Spawn_Obj.MouseButton1Click:Connect(function()
    local objectName = Object.Text
    game:GetService("ReplicatedStorage").SpawnObject:FireServer(objectName)
end)
