-- Fly Script by DeepSeek Chat
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

-- إنشاء واجهة المستخدم
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyGUI"
ScreenGui.Parent = Player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 50)
MainFrame.Position = UDim2.new(0.5, -100, 0.8, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local FlyButton = Instance.new("TextButton")
FlyButton.Name = "FlyButton"
FlyButton.Size = UDim2.new(0.4, 0, 0.8, 0)
FlyButton.Position = UDim2.new(0.05, 0, 0.1, 0)
FlyButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
FlyButton.BorderSizePixel = 0
FlyButton.Text = "FLY"
FlyButton.TextColor3 = Color3.new(1, 1, 1)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextSize = 14
FlyButton.Parent = MainFrame

local BoostButton = Instance.new("TextButton")
BoostButton.Name = "BoostButton"
BoostButton.Size = UDim2.new(0.4, 0, 0.8, 0)
BoostButton.Position = UDim2.new(0.55, 0, 0.1, 0)
BoostButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
BoostButton.BorderSizePixel = 0
BoostButton.Text = "BOOST"
BoostButton.TextColor3 = Color3.new(1, 1, 1)
BoostButton.Font = Enum.Font.GothamBold
BoostButton.TextSize = 14
BoostButton.Parent = MainFrame

local BoostIndicator = Instance.new("Frame")
BoostIndicator.Name = "BoostIndicator"
BoostIndicator.Size = UDim2.new(0, 10, 0, 10)
BoostIndicator.Position = UDim2.new(0.9, 0, 0.1, 0)
BoostIndicator.BackgroundColor3 = Color3.new(1, 0, 0)
BoostIndicator.BorderSizePixel = 0
BoostIndicator.Parent = MainFrame

-- دالة لتغيير لون المؤشر
local function setBoostIndicator(color)
    BoostIndicator.BackgroundColor3 = color
end

-- دالة لتفعيل/إلغاء تفعيل الطيران
local function toggleFly()
    flying = not flying
    
    if flying then
        FlyButton.Text = "STOP FLY"
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        Humanoid.WalkSpeed = originalWalkSpeed * 2
        Humanoid.JumpPower = 0
    else
        FlyButton.Text = "FLY"
        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        Humanoid.WalkSpeed = originalWalkSpeed
        Humanoid.JumpPower = originalJumpPower
        setBoostIndicator(Color3.new(1, 0, 0))
        boostActive = false
    end
end

-- دالة لتفعيل/إلغاء تفعيل الدفع
local function toggleBoost()
    if not flying then return end
    
    boostActive = not boostActive
    
    if boostActive then
        BoostButton.Text = "BOOST ON"
        setBoostIndicator(Color3.new(0, 1, 0))
    else
        BoostButton.Text = "BOOST"
        setBoostIndicator(Color3.new(1, 0, 0))
    end
end

-- التحكم في الطيران
local function fly()
    if not flying or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = Character.HumanoidRootPart
    local camera = workspace.CurrentCamera
    
    -- حساب الاتجاه بناء على مدخلات اللاعب
    local forward = camera.CFrame.LookVector
    local right = camera.CFrame.RightVector
    local up = Vector3.new(0, 1, 0)
    
    local direction = Vector3.new()
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        direction = direction + forward
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        direction = direction - forward
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        direction = direction + right
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        direction = direction - right
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        direction = direction + up
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        direction = direction - up
    end
    
    -- تطبيق السرعة
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

-- تحسينات الواجهة
local function applyButtonEffects(button)
    local originalSize = button.Size
    local originalPos = button.Position
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.new(0.3, 0.3, 0.3),
            Size = originalSize + UDim2.new(0, 5, 0, 5),
            Position = originalPos - UDim2.new(0, 2.5, 0, 2.5)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = originalColor,
            Size = originalSize,
            Position = originalPos
        }):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        }):Play()
    end)
end

applyButtonEffects(FlyButton)
applyButtonEffects(BoostButton)
