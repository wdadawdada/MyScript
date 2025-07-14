-- Fly Script by DeepSeek Chat - تصميم أنيق
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- إعدادات الطيران
local flying = false
local flySpeed = 2
local boostActive = false
local boostMultiplier = 2
local originalWalkSpeed = Humanoid.WalkSpeed
local originalJumpPower = Humanoid.JumpPower

-- إنشاء واجهة مستخدم أنيقة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyGUI"
ScreenGui.Parent = Player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 60)
MainFrame.Position = UDim2.new(0.5, -110, 0.85, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- إضافة زوايا مدورة
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local FlyButton = Instance.new("TextButton")
FlyButton.Name = "FlyButton"
FlyButton.Size = UDim2.new(0.4, 0, 0.7, 0)
FlyButton.Position = UDim2.new(0.05, 0, 0.15, 0)
FlyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlyButton.BorderSizePixel = 0
FlyButton.Text = "FLY"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.Font = Enum.Font.GothamMedium
FlyButton.TextSize = 14
FlyButton.AutoButtonColor = false
FlyButton.Parent = MainFrame

local FlyButtonCorner = Instance.new("UICorner")
FlyButtonCorner.CornerRadius = UDim.new(0, 8)
FlyButtonCorner.Parent = FlyButton

local BoostButton = Instance.new("TextButton")
BoostButton.Name = "BoostButton"
BoostButton.Size = UDim2.new(0.4, 0, 0.7, 0)
BoostButton.Position = UDim2.new(0.55, 0, 0.15, 0)
BoostButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BoostButton.BorderSizePixel = 0
BoostButton.Text = "BOOST"
BoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BoostButton.Font = Enum.Font.GothamMedium
BoostButton.TextSize = 14
BoostButton.AutoButtonColor = false
BoostButton.Parent = MainFrame

local BoostButtonCorner = Instance.new("UICorner")
BoostButtonCorner.CornerRadius = UDim.new(0, 8)
BoostButtonCorner.Parent = BoostButton

-- مؤشر Boost دائري
local BoostIndicator = Instance.new("Frame")
BoostIndicator.Name = "BoostIndicator"
BoostIndicator.Size = UDim2.new(0, 12, 0, 12)
BoostIndicator.Position = UDim2.new(0.9, -6, 0.5, -6)
BoostIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
BoostIndicator.BorderSizePixel = 0
BoostIndicator.Parent = MainFrame

local BoostIndicatorCorner = Instance.new("UICorner")
BoostIndicatorCorner.CornerRadius = UDim.new(1, 0)
BoostIndicatorCorner.Parent = BoostIndicator

-- ظل للمؤشر
local BoostIndicatorGlow = Instance.new("ImageLabel")
BoostIndicatorGlow.Name = "BoostIndicatorGlow"
BoostIndicatorGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
BoostIndicatorGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
BoostIndicatorGlow.BackgroundTransparency = 1
BoostIndicatorGlow.Image = "rbxassetid://5028857084"
BoostIndicatorGlow.ImageColor3 = Color3.fromRGB(255, 50, 50)
BoostIndicatorGlow.ScaleType = Enum.ScaleType.Slice
BoostIndicatorGlow.SliceCenter = Rect.new(24, 24, 24, 24)
BoostIndicatorGlow.Parent = BoostIndicator

-- دالة لتغيير لون المؤشر
local function setBoostIndicator(color)
    BoostIndicator.BackgroundColor3 = color
    BoostIndicatorGlow.ImageColor3 = color
    TweenService:Create(BoostIndicatorGlow, TweenInfo.new(0.2), {ImageTransparency = color == Color3.fromRGB(255,50,50) and 0.7 or 0.3}):Play()
end

-- دالة لتفعيل/إلغاء تفعيل الطيران
local function toggleFly()
    flying = not flying
    
    if flying then
        FlyButton.Text = "STOP FLY"
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        Humanoid.WalkSpeed = originalWalkSpeed * 2
        Humanoid.JumpPower = 0
        
        -- تأثير عند التفعيل
        TweenService:Create(FlyButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 160, 255)
        }):Play()
    else
        FlyButton.Text = "FLY"
        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        Humanoid.WalkSpeed = originalWalkSpeed
        Humanoid.JumpPower = originalJumpPower
        setBoostIndicator(Color3.fromRGB(255, 50, 50))
        boostActive = false
        
        -- إعادة لون الزر
        TweenService:Create(FlyButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        }):Play()
        TweenService:Create(BoostButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Text = "BOOST"
        }):Play()
    end
end

-- دالة لتفعيل/إلغاء تفعيل الدفع
local function toggleBoost()
    if not flying then return end
    
    boostActive = not boostActive
    
    if boostActive then
        BoostButton.Text = "BOOST ON"
        setBoostIndicator(Color3.fromRGB(50, 255, 50))
        
        -- تأثير عند التفعيل
        TweenService:Create(BoostButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 150, 50)
        }):Play()
    else
        BoostButton.Text = "BOOST"
        setBoostIndicator(Color3.fromRGB(255, 50, 50))
        
        -- إعادة لون الزر
        TweenService:Create(BoostButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        }):Play()
    end
end

-- التحكم في الطيران (نفس الدالة السابقة)
local function fly()
    if not flying or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = Character.HumanoidRootPart
    local camera = workspace.CurrentCamera
    
    local forward = camera.CFrame.LookVector
    local right = camera.CFrame.RightVector
    local up = Vector3.new(0, 1, 0)
    
    local direction = Vector3.new()
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + forward end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - forward end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + right end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - right end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + up end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - up end
    
    if direction.Magnitude > 0 then
        direction = direction.Unit
        local currentSpeed = boostActive and flySpeed * boostMultiplier or flySpeed
        rootPart.Velocity = direction * currentSpeed * 50
    else
        rootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

-- إعداد الأحداث
FlyButton.MouseButton1Click:Connect(toggleFly)
BoostButton.MouseButton1Click:Connect(toggleBoost)

-- أمر في الدردشة لتفعيل الطيران
Player.Chatted:Connect(function(message)
    if message:lower() == "/fly" then
        toggleFly()
    end
end)

-- تحديث الطيران في كل إطار
RunService.Heartbeat:Connect(fly)

-- تحسينات الواجهة مع تأثيرات ناعمة
local function applyButtonEffects(button)
    local originalSize = button.Size
    local originalPos = button.Position
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 80),
            Size = originalSize + UDim2.new(0, 4, 0, 4),
            Position = originalPos - UDim2.new(0, 2, 0, 2)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = originalColor,
            Size = originalSize,
            Position = originalPos
        }):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Size = originalSize - UDim2.new(0, 2, 0, 2),
            Position = originalPos + UDim2.new(0, 1, 0, 1)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 80),
            Size = originalSize,
            Position = originalPos
        }):Play()
    end)
end

applyButtonEffects(FlyButton)
applyButtonEffects(BoostButton)

-- تأثير ظهور ناعم
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.85, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 220, 0, 60),
    Position = UDim2.new(0.5, -110, 0.85, 0)
}:Play()
