--[[
  D7 Premium Hub v3.0
  Ultimate All-In-One Roblox Exploit UI
  Features: ESP, Player Mods, World Hacks, Fun Tools & More
  Designed for maximum performance and style
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Premium UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "D7_PremiumHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = CoreGui

-- Main Window with Premium Glass Effect
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainWindow"
MainFrame.Size = UDim2.new(0, 550, 0, 450)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Advanced UI Effects
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 14)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(90, 70, 150)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.5

local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 10, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 35))
}
BackgroundGradient.Rotation = 120
BackgroundGradient.Parent = MainFrame

-- Premium Header with Logo
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 60)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 14)

local HeaderGradient = Instance.new("UIGradient", Header)
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 70, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 40, 120))
}
HeaderGradient.Rotation = 90

-- D7 Premium Logo
local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 40, 0, 40)
LogoFrame.Position = UDim2.new(0, 15, 0, 10)
LogoFrame.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
LogoFrame.Parent = Header

local LogoCorner = Instance.new("UICorner", LogoFrame)
LogoCorner.CornerRadius = UDim.new(0, 8)

local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(1, 0, 1, 0)
LogoLabel.Text = "D7"
LogoLabel.Font = Enum.Font.GothamBlack
LogoLabel.TextSize = 24
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Parent = LogoFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0, 70, 0, 5)
Title.Text = "PREMIUM HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(220, 200, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 200, 0, 20)
SubTitle.Position = UDim2.new(0, 70, 0, 30)
SubTitle.Text = "ULTIMATE EXPLOIT SUITE"
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 12
SubTitle.TextColor3 = Color3.fromRGB(180, 160, 220)
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.BackgroundTransparency = 1
SubTitle.Parent = Header

-- Control Buttons with Hover Effects
local function CreateControlButton(name, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.Position = pos
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 8)
    
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(150, 120, 220)
    btnStroke.Thickness = 1
    
    btn.Parent = Header
    
    -- Hover animations
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(
                math.min(color.R * 255 * 1.3, 255),
                math.min(color.G * 255 * 1.3, 255),
                math.min(color.B * 255 * 1.3, 255)
            ),
            Size = UDim2.new(0, 32, 0, 32),
            Position = pos - UDim2.new(0, 1, 0, 1)
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = color,
            Size = UDim2.new(0, 30, 0, 30),
            Position = pos
        }):Play()
    end)
    
    return btn
end

local CloseBtn = CreateControlButton("CloseBtn", "✕", UDim2.new(1, -40, 0, 15), Color3.fromRGB(220, 80, 80))
local MinimizeBtn = CreateControlButton("MinimizeBtn", "─", UDim2.new(1, -80, 0, 15), Color3.fromRGB(80, 80, 140))
local SettingsBtn = CreateControlButton("SettingsBtn", "⚙", UDim2.new(1, -120, 0, 15), Color3.fromRGB(70, 70, 130))

-- Toggle Button (D7 Logo)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
ToggleButton.Text = "D7"
ToggleButton.Font = Enum.Font.GothamBlack
ToggleButton.TextSize = 24
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
ToggleButton.BorderSizePixel = 0
ToggleButton.Visible = false
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(0, 15)

local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Color = Color3.fromRGB(180, 140, 255)
ToggleStroke.Thickness = 2

-- Button functionality
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleButton.Visible = true
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleButton.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tab System
local TabsFrame = Instance.new("Frame", MainFrame)
TabsFrame.Size = UDim2.new(1, -20, 0, 45)
TabsFrame.Position = UDim2.new(0, 10, 0, 70)
TabsFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
TabsFrame.BorderSizePixel = 0

local TabsCorner = Instance.new("UICorner", TabsFrame)
TabsCorner.CornerRadius = UDim.new(0, 10)

local TabsGradient = Instance.new("UIGradient", TabsFrame)
TabsGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 30, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 20, 50))
}

-- Tab Buttons
local function CreateTabButton(name, text, pos)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name
    tabBtn.Text = text
    tabBtn.Size = UDim2.new(0, 120, 0, 40)
    tabBtn.Position = pos
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 14
    tabBtn.TextColor3 = Color3.fromRGB(200, 180, 240)
    tabBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 70)
    tabBtn.BorderSizePixel = 0
    tabBtn.AutoButtonColor = false
    
    local tabCorner = Instance.new("UICorner", tabBtn)
    tabCorner.CornerRadius = UDim.new(0, 8)
    
    local tabStroke = Instance.new("UIStroke", tabBtn)
    tabStroke.Color = Color3.fromRGB(100, 80, 160)
    tabStroke.Thickness = 1
    
    tabBtn.Parent = TabsFrame
    
    -- Hover effects
    tabBtn.MouseEnter:Connect(function()
        TweenService:Create(tabBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(70, 60, 100),
            TextColor3 = Color3.fromRGB(255, 240, 255)
        }):Play()
    end)
    
    tabBtn.MouseLeave:Connect(function()
        if not tabBtn.Active then
            TweenService:Create(tabBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 40, 70),
                TextColor3 = Color3.fromRGB(200, 180, 240)
            }):Play()
        end
    end)
    
    return tabBtn
end

local ESPTab = CreateTabButton("ESP", "VISUAL", UDim2.new(0, 10, 0, 2))
local PlayerTab = CreateTabButton("Player", "PLAYER", UDim2.new(0, 140, 0, 2))
local WorldTab = CreateTabButton("World", "WORLD", UDim2.new(0, 270, 0, 2))
local FunTab = CreateTabButton("Fun", "FUN", UDim2.new(0, 400, 0, 2))

-- Content Pages
local function CreateContentPage()
    local page = Instance.new("ScrollingFrame")
    page.Name = "ContentPage"
    page.Size = UDim2.new(1, -20, 1, -140)
    page.Position = UDim2.new(0, 10, 0, 125)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 5
    page.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 160)
    page.Visible = false
    page.Parent = MainFrame
    
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 12)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    return page
end

local ESPPage = CreateContentPage()
local PlayerPage = CreateContentPage()
local WorldPage = CreateContentPage()
local FunPage = CreateContentPage()

-- Tab Activation System
local function ActivateTab(tab, page)
    ESPPage.Visible = false
    PlayerPage.Visible = false
    WorldPage.Visible = false
    FunPage.Visible = false
    
    page.Visible = true
    
    -- Reset all tabs
    for _, btn in ipairs(TabsFrame:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.BackgroundColor3 = Color3.fromRGB(50, 40, 70)
            btn.TextColor3 = Color3.fromRGB(200, 180, 240)
            btn.Active = false
        end
    end
    
    -- Highlight active tab
    tab.BackgroundColor3 = Color3.fromRGB(90, 70, 150)
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Active = true
    
    -- Play animation
    TweenService:Create(tab, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(120, 80, 200),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end

ESPTab.MouseButton1Click:Connect(function() ActivateTab(ESPTab, ESPPage) end)
PlayerTab.MouseButton1Click:Connect(function() ActivateTab(PlayerTab, PlayerPage) end)
WorldTab.MouseButton1Click:Connect(function() ActivateTab(WorldTab, WorldPage) end)
FunTab.MouseButton1Click:Connect(function() ActivateTab(FunTab, FunPage) end)

-- Activate default tab
ActivateTab(ESPTab, ESPPage)

-- Premium UI Elements Creator
local function CreateToggle(name, parent, callback, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 50)
    container.BackgroundTransparency = 1
    container.LayoutOrder = #parent:GetChildren()
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, -10, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = name
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 15
    label.TextColor3 = Color3.fromRGB(230, 220, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = container
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.3, -10, 0.8, 0)
    toggle.Position = UDim2.new(0.7, 0, 0.1, 0)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 14
    toggle.Text = default and "ON" or "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.BackgroundColor3 = default and Color3.fromRGB(80, 160, 80) or Color3.fromRGB(160, 80, 80)
    toggle.BorderSizePixel = 0
    toggle.AutoButtonColor = false
    
    local toggleCorner = Instance.new("UICorner", toggle)
    toggleCorner.CornerRadius = UDim.new(0, 8)
    
    local toggleStroke = Instance.new("UIStroke", toggle)
    toggleStroke.Color = Color3.fromRGB(150, 120, 220)
    toggleStroke.Thickness = 1
    
    toggle.Parent = container
    
    local state = default or false
    
    -- Toggle animations
    toggle.MouseEnter:Connect(function()
        TweenService:Create(toggle, TweenInfo.new(0.1), {
            BackgroundColor3 = state and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 100, 100),
            Size = UDim2.new(0.3, -8, 0.82, 0)
        }):Play()
    end)
    
    toggle.MouseLeave:Connect(function()
        TweenService:Create(toggle, TweenInfo.new(0.1), {
            BackgroundColor3 = state and Color3.fromRGB(80, 160, 80) or Color3.fromRGB(160, 80, 80),
            Size = UDim2.new(0.3, -10, 0.8, 0)
        }):Play()
    end)
    
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = state and "ON" or "OFF"
        TweenService:Create(toggle, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(80, 160, 80) or Color3.fromRGB(160, 80, 80)
        }):Play()
        callback(state)
    end)
    
    return toggle
end

local function CreateSlider(name, parent, min, max, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 70)
    container.BackgroundTransparency = 1
    container.LayoutOrder = #parent:GetChildren()
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = name
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 15
    label.TextColor3 = Color3.fromRGB(230, 220, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = container
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 60, 0, 20)
    valueLabel.Position = UDim2.new(1, -60, 0, 0)
    valueLabel.Text = tostring(default)
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.TextSize = 14
    valueLabel.TextColor3 = Color3.fromRGB(200, 190, 240)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.BackgroundTransparency = 1
    valueLabel.Parent = container
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Size = UDim2.new(1, -70, 0, 6)
    sliderTrack.Position = UDim2.new(0, 0, 0, 30)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(50, 40, 80)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = container
    
    local trackCorner = Instance.new("UICorner", sliderTrack)
    trackCorner.CornerRadius = UDim.new(0, 3)
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    
    local fillCorner = Instance.new("UICorner", sliderFill)
    fillCorner.CornerRadius = UDim.new(0, 3)
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 16, 0, 16)
    sliderButton.Position = UDim2.new((default - min)/(max - min), -8, 0.5, -8)
    sliderButton.Text = ""
    sliderButton.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.AutoButtonColor = false
    sliderButton.Parent = sliderTrack
    
    local buttonCorner = Instance.new("UICorner", sliderButton)
    buttonCorner.CornerRadius = UDim.new(0, 8)
    
    local buttonStroke = Instance.new("UIStroke", sliderButton)
    buttonStroke.Color = Color3.fromRGB(255, 255, 255)
    buttonStroke.Thickness = 1
    
    local dragging = false
    
    local function updateValue(input)
        local xOffset = (input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X
        xOffset = math.clamp(xOffset, 0, 1)
        local value = math.floor(min + (max - min) * xOffset)
        
        sliderFill.Size = UDim2.new(xOffset, 0, 1, 0)
        sliderButton.Position = UDim2.new(xOffset, -8, 0.5, -8)
        valueLabel.Text = tostring(value)
        callback(value)
    end
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input)
        end
    end)
    
    sliderTrack.MouseButton1Down:Connect(function(x, y)
        updateValue({Position = Vector2.new(x, y)})
    end)
    
    return {
        SetValue = function(value)
            value = math.clamp(value, min, max)
            local xOffset = (value - min)/(max - min)
            sliderFill.Size = UDim2.new(xOffset, 0, 1, 0)
            sliderButton.Position = UDim2.new(xOffset, -8, 0.5, -8)
            valueLabel.Text = tostring(value)
        end
    }
end

-- Populate Tabs with Features

-- VISUAL TAB (ESP)
CreateToggle("Box ESP", ESPPage, function(state)
    -- Box ESP implementation
end, false)

CreateToggle("Name ESP", ESPPage, function(state)
    -- Name ESP implementation
end, false)

CreateToggle("Tracer ESP", ESPPage, function(state)
    -- Tracer lines to players
end, false)

CreateToggle("Chams ESP", ESPPage, function(state)
    -- Wallhack/Chams implementation
end, false)

CreateToggle("Health Bar", ESPPage, function(state)
    -- Health bar display
end, true)

-- PLAYER TAB
CreateToggle("Infinite Jump", PlayerPage, function(state)
    if state then
        _G.InfiniteJump = UIS.JumpRequest:Connect(function()
            humanoid:ChangeState("Jumping")
        end)
    else
        if _G.InfiniteJump then _G.InfiniteJump:Disconnect() end
    end
end, false)

local speedSlider = CreateSlider("Walk Speed", PlayerPage, 16, 200, 16, function(value)
    humanoid.WalkSpeed = value
end)

local jumpSlider = CreateSlider("Jump Power", PlayerPage, 50, 500, 50, function(value)
    humanoid.JumpPower = value
end)

CreateToggle("No Clip", PlayerPage, function(state)
    if state then
        _G.NoClip = RunService.Stepped:Connect(function()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if _G.NoClip then _G.NoClip:Disconnect() end
    end
end, false)

CreateToggle("Fly Mode", PlayerPage, function(state)
    -- Fly implementation
end, false)

CreateToggle("Invisibility", PlayerPage, function(state)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = state and 1 or 0
            if part:FindFirstChildOfClass("Decal") then
                part:FindFirstChildOfClass("Decal").Transparency = state and 1 or 0
            end
        end
    end
end, false)

-- WORLD TAB
CreateToggle("Fullbright", WorldPage, function(state)
    if state then
        Lighting.GlobalShadows = false
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
    else
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
    end
end, false)

CreateToggle("No Fog", WorldPage, function(state)
    Lighting.FogEnd = state and 100000 or 1000
end, false)

CreateToggle("Time Changer", WorldPage, function(state)
    if state then
        _G.TimeLoop = RunService.Heartbeat:Connect(function()
            Lighting.ClockTime = Lighting.ClockTime + 0.01
            if Lighting.ClockTime >= 24 then
                Lighting.ClockTime = 0
            end
        end)
    else
        if _G.TimeLoop then _G.TimeLoop:Disconnect() end
    end
end, false)

CreateToggle("Gravity Hack", WorldPage, function(state)
    workspace.Gravity = state and 25 or 196.2
end, false)

-- FUN TAB
CreateToggle("Click TP", FunPage, function(state)
    if state then
        _G.ClickTP = UIS.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local ray = workspace:ScreenPointToRay(input.Position.X, input.Position.Y, 0)
                local part, position = workspace:FindPartOnRay(ray, character)
                if part then
                    character:MoveTo(position)
                end
            end
        end)
    else
        if _G.ClickTP then _G.ClickTP:Disconnect() end
    end
end, false)

CreateToggle("Anti-AFK", FunPage, function(state)
    if state then
        _G.AntiAFK = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    else
        if _G.AntiAFK then _G.AntiAFK:Disconnect() end
    end
end, true)

CreateToggle("Spin Bot", FunPage, function(state)
    if state then
        _G.SpinBot = RunService.Heartbeat:Connect(function()
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
            end
        end)
    else
        if _G.SpinBot then _G.SpinBot:Disconnect() end
    end
end, false)

CreateToggle("Headless", FunPage, function(state)
    if character:FindFirstChild("Head") then
        character.Head.Transparency = state and 1 or 0
        for _, face in pairs(character.Head:GetChildren()) do
            if face:IsA("Decal") then
                face.Transparency = state and 1 or 0
            end
        end
    end
end, false)

-- Ensure pages update their canvas size
for _, page in ipairs({ESPPage, PlayerPage, WorldPage, FunPage}) do
    page:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, page.UIListLayout.AbsoluteContentSize.Y + 20)
    end)
end

-- Initialize default values
speedSlider.SetValue(16)
jumpSlider.SetValue(50)

-- Notification system
local function Notify(title, message, duration)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 80)
    notif.Position = UDim2.new(1, 10, 1, -90)
    notif.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui
    
    local corner = Instance.new("UICorner", notif)
    corner.CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", notif)
    stroke.Color = Color3.fromRGB(100, 80, 160)
    stroke.Thickness = 2
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = Color3.fromRGB(220, 200, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = notif
    
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(1, -20, 1, -40)
    msgLabel.Position = UDim2.new(0, 10, 0, 35)
    msgLabel.Text = message
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.TextSize = 14
    msgLabel.TextColor3 = Color3.fromRGB(200, 180, 240)
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.TextYAlignment = Enum.TextYAlignment.Top
    msgLabel.BackgroundTransparency = 1
    msgLabel.Parent = notif
    
    TweenService:Create(notif, TweenInfo.new(0.3), {
        Position = UDim2.new(1, -310, 1, -90)
    }):Play()
    
    delay(duration or 3, function()
        TweenService:Create(notif, TweenInfo.new(0.3), {
            Position = UDim2.new(1, 10, 1, -90)
        }):Play()
        wait(0.3)
        notif:Destroy()
    end)
end

-- Initial notification
Notify("D7 Premium Hub", "Successfully loaded! Enjoy your premium experience.", 5)
