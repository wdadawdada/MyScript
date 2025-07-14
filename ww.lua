-- Fly Script v2.0 - تصميم أنيق وعمل كامل
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- إعدادات الطيران
local flying = false
local flySpeed = 50
local boostActive = false
local boostMultiplier = 2
local originalWalkSpeed = Humanoid.WalkSpeed
local originalJumpPower = Humanoid.JumpPower

-- إنشاء واجهة مستخدم عصرية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyGUI"
ScreenGui.Parent = Player.PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 70)
MainFrame.Position = UDim2.new(0.5, -120, 0.9, -35)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- زوايا مدورة للإطار الرئيسي
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- ظل للإطار
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 1
UIStroke.Color = Color3.fromRGB(80, 80, 90)
UIStroke.Transparency = 0.7
UIStroke.Parent = MainFrame

-- زر الطيران
local FlyButton = Instance.new("TextButton")
FlyButton.Name = "FlyButton"
FlyButton.Size = UDim2.new(0.45, 0, 0.7, 0)
FlyButton.Position = UDim2.new(0.025, 0, 0.15, 0)
FlyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
FlyButton.BorderSizePixel = 0
FlyButton.Text = "🚀 FLY"
FlyButton.TextColor3 = Color3.fromRGB(240, 240, 245)
FlyButton.Font = Enum.Font.GothamSemibold
FlyButton.TextSize = 14
FlyButton.TextXAlignment = Enum.TextXAlignment.Left
FlyButton.AutoButtonColor = false
FlyButton.Parent = MainFrame

-- زوايا مدورة لزر الطيران
local FlyButtonCorner = Instance.new("UICorner")
FlyButtonCorner.CornerRadius = UDim.new(0, 10)
FlyButtonCorner.Parent = FlyButton

-- أيقونة الطيران
local FlyIcon = Instance.new("ImageLabel")
FlyIcon.Name = "FlyIcon"
FlyIcon.Size = UDim2.new(0, 20, 0, 20)
FlyIcon.Position = UDim2.new(0.8, 0, 0.5, -10)
FlyIcon.BackgroundTransparency = 1
FlyIcon.Image = "rbxassetid://3926305904"
FlyIcon.ImageRectOffset = Vector2.new(324, 364)
FlyIcon.ImageRectSize = Vector2.new(36, 36)
FlyIcon.ImageColor3 = Color3.fromRGB(200, 200, 210)
FlyIcon.Parent = FlyButton

-- زر الـ Boost
local BoostButton = Instance.new("TextButton")
BoostButton.Name = "BoostButton"
BoostButton.Size = UDim2.new(0.45, 0, 0.7, 0)
BoostButton.Position = UDim2.new(0.525, 0, 0.15, 0)
BoostButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
BoostButton.BorderSizePixel = 0
BoostButton.Text = "⚡ BOOST"
BoostButton.TextColor3 = Color3.fromRGB(240, 240, 245)
BoostButton.Font = Enum.Font.GothamSemibold
BoostButton.TextSize = 14
BoostButton.TextXAlignment = Enum.TextXAlignment.Left
BoostButton.AutoButtonColor = false
BoostButton.Parent = MainFrame

-- زوايا مدورة لزر الـ Boost
local BoostButtonCorner = Instance.new("UICorner")
BoostButtonCorner.CornerRadius = UDim.new(0, 10)
BoostButtonCorner.Parent = BoostButton

-- أيقونة الـ Boost
local BoostIcon = Instance.new("ImageLabel")
BoostIcon.Name = "BoostIcon"
BoostIcon.Size = UDim2.new(0, 20, 0, 20)
BoostIcon.Position = UDim2.new(0.8, 0, 0.5, -10)
BoostIcon.BackgroundTransparency = 1
BoostIcon.Image = "rbxassetid://3926307971"
BoostIcon.ImageRectOffset = Vector2.new(324, 124)
BoostIcon.ImageRectSize = Vector2.new(36, 36)
BoostIcon.ImageColor3 = Color3.fromRGB(200, 200, 210)
BoostIcon.Parent = BoostButton

-- مؤشر Boost دائري
local BoostIndicator = Instance.new("Frame")
BoostIndicator.Name = "BoostIndicator"
BoostIndicator.Size = UDim2.new(0, 14, 0, 14)
BoostIndicator.Position = UDim2.new(0.9, -7, 0.5, -7)
BoostIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
BoostIndicator.BorderSizePixel = 0
BoostIndicator.Parent = MainFrame

-- زوايا مدورة للمؤشر (لجعله دائرياً)
local BoostIndicatorCorner = Instance.new("UICorner")
BoostIndicatorCorner.CornerRadius = UDim.new(1, 0)
BoostIndicatorCorner.Parent = BoostIndicator

-- تأثير توهج للمؤشر
local BoostIndicatorGlow = Instance.new("ImageLabel")
BoostIndicatorGlow.Name = "BoostIndicatorGlow"
BoostIndicatorGlow.Size = UDim2.new(2, 0, 2, 0)
BoostIndicatorGlow.Position = UDim2.new(-0.5, 0, -0.5, 0)
BoostIndicatorGlow.BackgroundTransparency = 1
BoostIndicatorGlow.Image = "rbxassetid://5028857084"
BoostIndicatorGlow.ImageColor3 = Color3.fromRGB(255, 60, 60)
BoostIndicatorGlow.ScaleType = Enum.ScaleType.Slice
BoostIndicatorGlow.SliceCenter = Rect.new(24, 24, 24, 24)
BoostIndicatorGlow.ImageTransparency = 0.8
BoostIndicatorGlow.Parent = BoostIndicator

-- دالة لتغيير لون المؤشر
local function setBoostIndicator(color)
    BoostIndicator.BackgroundColor3 = color
    BoostIndicatorGlow.ImageColor3 = color
    TweenService:Create(BoostIndicatorGlow, TweenInfo.new(0.3), {
        ImageTransparency = color == Color3.fromRGB(255,60,60) and 0.8 or 0.5
    }):Play()
end

-- دالة لتفعيل/إلغاء تفعيل الطيران
local function toggleFly()
    flying = not flying
    
    if flying then
        FlyButton.Text = "✋ STOP FLY"
        FlyIcon.ImageRectOffset = Vector2.new(964, 324)
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        Humanoid.WalkSpeed = 0
        Humanoid.JumpPower = 0
        
        -- تأثير عند التفعيل
        TweenService:Create(FlyButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(80, 160, 220)
        }):Play()
        TweenService:Create(FlyIcon, TweenInfo.new(0.3), {
            ImageColor3 = Color3.fromRGB(240, 240, 245)
        }):Play()
    else
        FlyButton.Text = "🚀 FLY"
        FlyIcon.ImageRectOffset = Vector2.new(324, 364)
        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        Humanoid.WalkSpeed = originalWalkSpeed
        Humanoid.JumpPower = originalJumpPower
        setBoostIndicator(Color3.fromRGB(255, 60, 60))
        boostActive = false
        
        -- إعادة الألوان إلى الوضع الطبيعي
        TweenService:Create(FlyButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        }):Play()
        TweenService:Create(BoostButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 70),
            Text = "⚡ BOOST"
        }):Play()
        TweenService:Create(BoostIcon, TweenInfo.new(0.3), {
            ImageColor3 = Color3.fromRGB(200, 200, 210)
        }):Play()
    end
end

-- دالة لتفعيل/إلغاء تفعيل الـ Boost
local function toggleBoost()
    if not flying then return end
    
    boostActive = not boostActive
    
    if boostActive then
        BoostButton.Text = "⚡ BOOST ON"
        setBoostIndicator(Color3.fromRGB(60, 255, 60))
        
        -- تأثير عند التفعيل
        TweenService:Create(BoostButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(220, 150, 60)
        }):Play()
        TweenService:Create(BoostIcon, TweenInfo.new(0.3), {
            ImageColor3 = Color3.fromRGB(255, 255, 200)
        }):Play()
    else
        BoostButton.Text = "⚡ BOOST"
        setBoostIndicator(Color3.fromRGB(255, 60, 60))
        
        -- إعادة اللون إلى الوضع الطبيعي
        TweenService:Create(BoostButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        }):Play()
        TweenService:Create(BoostIcon, TweenInfo.new(0.3), {
            ImageColor3 = Color3.fromRGB(200, 200, 210)
        }):Play()
    end
end

-- التحكم في الطيران
local function fly()
    if not flying or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = Character.HumanoidRootPart
    local camera = workspace.CurrentCamera
    
    -- حساب الاتجاه بناءً على مدخلات اللاعب
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
    
    -- تطبيق السرعة
    if direction.Magnitude > 0 then
        direction = direction.Unit
        local currentSpeed = boostActive and flySpeed * boostMultiplier or flySpeed
        rootPart.Velocity = direction * currentSpeed
    else
        rootPart.Velocity = Vector3.new(rootPart.Velocity.X * 0.9, 0, rootPart.Velocity.Z * 0.9)
    end
end

-- إعداد أحداث الأزرار
FlyButton.MouseButton1Click:Connect(toggleFly)
BoostButton.MouseButton1Click:Connect(toggleBoost)

-- أمر في الدردشة لتفعيل الطيران
Player.Chatted:Connect(function(message)
    if string.lower(message) == "/fly" then
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
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 90),
            Size = originalSize + UDim2.new(0, 4, 0, 4),
            Position = originalPos - UDim2.new(0, 2, 0, 2)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = originalColor,
            Size = originalSize,
            Position = originalPos
        }):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 50),
            Size = originalSize - UDim2.new(0, 2, 0, 2),
            Position = originalPos + UDim2.new(0, 1, 0, 1)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 90),
            Size = originalSize,
            Position = originalPos
        }):Play()
    end)
end

applyButtonEffects(FlyButton)
applyButtonEffects(BoostButton)

-- تأثير ظهور ناعم للواجهة
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.9, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
    Size = UDim2.new(0, 240, 0, 70),
    Position = UDim2.new(0.5, -120, 0.9, -35)
}):Play()

-- إعادة التهيئة عند إعادة توليد الشخصية
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    originalWalkSpeed = Humanoid.WalkSpeed
    originalJumpPower = Humanoid.JumpPower
    
    if flying then
        flying = false
        toggleFly() -- إعادة تفعيل الطيران إذا كان نشطاً
    end
end)
