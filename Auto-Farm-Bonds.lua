local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

if game.PlaceId ~= 116495829188952 then
    LocalPlayer:Kick("This script can only be used in Dead Rails.")
    return
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HKTDRoblox_DeadRails"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (CoreGui:FindFirstChild("RobloxGui") or CoreGui)

local function makeCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim2.new(0, radius)
    corner.Parent = parent
    return corner
end

local function makeStroke(parent, color)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function addGlowEffect(frame, strokeColor)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.BackgroundTransparency = 1
    glow.Position = UDim2.new(0, -15, 0, -15)
    glow.Size = UDim2.new(1, 30, 1, 30)
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = strokeColor
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(24, 24, 276, 276)
    glow.Parent = frame

    task.spawn(function()
        while frame and frame.Parent do
            TweenService:Create(glow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.2}):Play()
            task.wait(1.2)
            TweenService:Create(glow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.8}):Play()
            task.wait(1.2)
        end
    end)
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 190)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -95)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui
makeCorner(MainFrame, 10)
makeStroke(MainFrame, Color3.fromRGB(255, 140, 0))
addGlowEffect(MainFrame, Color3.fromRGB(255, 140, 0))

local function makeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(MainFrame)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Auto Farm Bonds - Dead Rails"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

local TimeBox = Instance.new("Frame")
TimeBox.Size = UDim2.new(0, 140, 0, 35)
TimeBox.Position = UDim2.new(0, 15, 0, 40)
TimeBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TimeBox.Parent = MainFrame
makeCorner(TimeBox, 6)
makeStroke(TimeBox, Color3.fromRGB(50, 50, 50))

local TimeText = Instance.new("TextLabel")
TimeText.Size = UDim2.new(1, 0, 1, 0)
TimeText.BackgroundTransparency = 1
TimeText.Text = "Time: 00:00:00"
TimeText.TextColor3 = Color3.fromRGB(50, 205, 50)
TimeText.Font = Enum.Font.SourceSansBold
TimeText.TextSize = 15
TimeText.Parent = TimeBox

local BondsBox = Instance.new("Frame")
BondsBox.Size = UDim2.new(0, 140, 0, 35)
BondsBox.Position = UDim2.new(1, -155, 0, 40)
BondsBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
BondsBox.Parent = MainFrame
makeCorner(BondsBox, 6)
makeStroke(BondsBox, Color3.fromRGB(50, 50, 50))

local BondsText = Instance.new("TextLabel")
BondsText.Size = UDim2.new(1, 0, 1, 0)
BondsText.BackgroundTransparency = 1
BondsText.Text = "Bonds: 00"
BondsText.TextColor3 = Color3.fromRGB(255, 140, 0)
BondsText.Font = Enum.Font.SourceSansBold
BondsText.TextSize = 15
BondsText.Parent = BondsBox

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -30, 0, 30)
StatusText.Position = UDim2.new(0, 15, 0, 85)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Status: Joining the Game..."
StatusText.TextColor3 = Color3.fromRGB(204, 153, 0)
StatusText.Font = Enum.Font.SourceSansBold
StatusText.TextSize = 14
StatusText.TextWrapped = true
StatusText.Parent = MainFrame

local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0, 140, 0, 35)
CopyBtn.Position = UDim2.new(0, 15, 0, 130)
CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 215)
CopyBtn.Text = "Copy Discord"
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Font = Enum.Font.SourceSansBold
CopyBtn.TextSize = 15
CopyBtn.Parent = MainFrame
makeCorner(CopyBtn, 6)

local CreditBtn = Instance.new("TextButton")
CreditBtn.Size = UDim2.new(0, 140, 0, 35)
CreditBtn.Position = UDim2.new(1, -155, 0, 130)
CreditBtn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
CreditBtn.Text = "Credit"
CreditBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditBtn.Font = Enum.Font.SourceSansBold
CreditBtn.TextSize = 15
CreditBtn.Parent = MainFrame
makeCorner(CreditBtn, 6)

local CreditFrame = Instance.new("Frame")
CreditFrame.Name = "CreditFrame"
CreditFrame.Size = UDim2.new(0.9, 0, 0.85, 0)
CreditFrame.Position = UDim2.new(0.05, 0, 0.075, 0)
CreditFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
CreditFrame.Visible = false
CreditFrame.Parent = ScreenGui
makeCorner(CreditFrame, 10)
makeStroke(CreditFrame, Color3.fromRGB(50, 205, 50))
addGlowEffect(CreditFrame, Color3.fromRGB(50, 205, 50))

local CreditTitle = Instance.new("TextLabel")
CreditTitle.Size = UDim2.new(1, -20, 0, 30)
CreditTitle.Position = UDim2.new(0, 10, 0, 10)
CreditTitle.BackgroundTransparency = 1
CreditTitle.Text = "SCRIPT CREATED BY HKTD ROBLOX"
CreditTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditTitle.Font = Enum.Font.SourceSansBold
CreditTitle.TextSize = 16
CreditTitle.Parent = CreditFrame

local CreditText = Instance.new("TextLabel")
CreditText.Size = UDim2.new(1, -30, 1, -100)
CreditText.Position = UDim2.new(0, 15, 0, 45)
CreditText.BackgroundTransparency = 1
CreditText.Text = "🇻🇳 <b>Tiếng Việt:</b>\nXin Chào! Tôi là <b>Hoàng Kim Tiến Đạt</b> (<b>HKTD Roblox</b>). Cảm ơn bạn đã sử dụng Script của mình nếu thấy lỗi hãy vào <b>Discord</b> của mình để báo cáo lỗi nhé!\n\n🇺🇸 <b>English:</b>\nHello! I am <b>Hoàng Kim Tiến Đạt</b> (<b>HKTD Roblox</b>). Thank you for using my Script, if you encounter any errors, please join my <b>Discord</b> to report them!"
CreditText.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditText.Font = Enum.Font.SourceSans
CreditText.TextSize = 14
CreditText.RichText = true
CreditText.TextWrapped = true
CreditText.Parent = CreditFrame

local CreditCopyBtn = Instance.new("TextButton")
CreditCopyBtn.Size = UDim2.new(0.43, 0, 0, 35)
CreditCopyBtn.Position = UDim2.new(0.05, 0, 1, -45)
CreditCopyBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 215)
CreditCopyBtn.Text = "Copy Discord"
CreditCopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditCopyBtn.Font = Enum.Font.SourceSansBold
CreditCopyBtn.TextSize = 15
CreditCopyBtn.Parent = CreditFrame
makeCorner(CreditCopyBtn, 6)

local CreditOkBtn = Instance.new("TextButton")
CreditOkBtn.Size = UDim2.new(0.43, 0, 0, 35)
CreditOkBtn.Position = UDim2.new(0.52, 0, 1, -45)
CreditOkBtn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
CreditOkBtn.Text = "OK"
CreditOkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditOkBtn.Font = Enum.Font.SourceSansBold
CreditOkBtn.TextSize = 15
CreditOkBtn.Parent = CreditFrame
makeCorner(CreditOkBtn, 6)

local function handleDiscordCopy(btn)
    if setclipboard then
        setclipboard("https://discord.gg/2ACZAkcmDP")
    end
    btn.Text = "Link Copied!"
    task.delay(2, function()
        btn.Text = "Copy Discord"
    end)
end

CopyBtn.MouseButton1Click:Connect(function() handleDiscordCopy(CopyBtn) end)
CreditCopyBtn.MouseButton1Click:Connect(function() handleDiscordCopy(CreditCopyBtn) end)

CreditBtn.MouseButton1Click:Connect(function()
    CreditFrame.Visible = true
end)

CreditOkBtn.MouseButton1Click:Connect(function()
    CreditFrame.Visible = false
end)

local elapsedSeconds = 0
local isTimerRunning = false

task.spawn(function()
    while true do
        task.wait(1)
        if isTimerRunning then
            elapsedSeconds = elapsedSeconds + 1
            local hrs = math.floor(elapsedSeconds / 3600)
            local mins = math.floor((elapsedSeconds % 3600) / 60)
            local secs = elapsedSeconds % 60
            TimeText.Text = string.format("Time: %02d:%02d:%02d", hrs, mins, secs)
        end
    end
end)

local bondCount = 0
local function setStatus(statusString)
    StatusText.Text = statusString
end

local function isPlayerInLobby()
    if workspace:FindFirstChild("Lobby") or workspace:FindFirstChild("LobbyMap") or workspace:FindFirstChild("LobbySpawn") then
        return true
    end
    local gui = LocalPlayer:FindFirstChild("PlayerGui")
    if gui and (gui:FindFirstChild("LobbyGui") or gui:FindFirstChild("MainMenu")) then
        return true
    end
    return false
end

local function enterSoloGame()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    local soloDoor = nil
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local n = string.lower(v.Name)
            local pN = v.Parent and string.lower(v.Parent.Name) or ""
            if (string.find(n, "solo") or string.find(n, "1/1") or string.find(pN, "solo") or string.find(pN, "1/1")) and not string.find(n, "gui") then
                soloDoor = v
                break
            end
        end
    end

    if soloDoor then
        hrp.CFrame = soloDoor.CFrame + Vector3.new(0, 3, 0)
        local prompt = soloDoor:FindFirstChildWhichIsA("ProximityPrompt", true) or (soloDoor.Parent and soloDoor.Parent:FindFirstChildWhichIsA("ProximityPrompt", true))
        if prompt then
            fireproximityprompt(prompt)
        end
        local touch = soloDoor:FindFirstChildWhichIsA("TouchTransmitter", true)
        if touch then
            firetouchinterest(hrp, soloDoor, 0)
            task.wait(0.1)
            firetouchinterest(hrp, soloDoor, 1)
        end
    end
end

local function getSingleBond()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj and obj.Parent then
            local nameLower = string.lower(obj.Name)
            if string.find(nameLower, "bond") then
                local mainObj = obj
                if obj:IsA("BasePart") and obj.Parent and obj.Parent:IsA("Model") and string.find(string.lower(obj.Parent.Name), "bond") then
                    mainObj = obj.Parent
                end
                local part = mainObj:IsA("BasePart") and mainObj or mainObj:FindFirstChildWhichIsA("BasePart", true)
                if part then
                    return mainObj, part
                end
            end
        end
    end
    return nil, nil
end

local function moveBondToPlayer(bondObj, bondPart)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local cam = workspace.CurrentCamera
    local targetPos = cam.CFrame.Position + (cam.CFrame.LookVector * 1.5)
    local targetCFrame = CFrame.new(targetPos)

    if bondObj:IsA("Model") then
        bondObj:PivotTo(targetCFrame)
    else
        bondPart.CFrame = targetCFrame
    end
    
    bondPart.Velocity = Vector3.new(0, 0, 0)
    bondPart.RotVelocity = Vector3.new(0, 0, 0)
    
    local prompt = bondObj:FindFirstChildWhichIsA("ProximityPrompt", true) or bondPart:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt then
        fireproximityprompt(prompt)
    end
    
    local touch = bondPart:FindFirstChildWhichIsA("TouchTransmitter", true)
    if touch then
        firetouchinterest(char.HumanoidRootPart, bondPart, 0)
        task.wait(0.02)
        firetouchinterest(char.HumanoidRootPart, bondPart, 1)
    end
end

local function startAutoFarm()
    while task.wait(0.1) do
        if isPlayerInLobby() then
            isTimerRunning = false
            setStatus("Status: Joining the Game...")
            enterSoloGame()
            task.wait(2)
        else
            isTimerRunning = true
            setStatus("Status: Getting All Bonds...")

            local bondObj, bondPart = getSingleBond()

            if bondObj and bondPart then
                while bondObj and bondObj.Parent and not isPlayerInLobby() do
                    moveBondToPlayer(bondObj, bondPart)
                    task.wait(0.03)
                end

                if not (bondObj and bondObj.Parent) then
                    bondCount = bondCount + 1
                    BondsText.Text = string.format("Bonds: %02d", bondCount)
                end
            else
                task.wait(0.5)
                local checkObj, checkPart = getSingleBond()
                if not checkObj then
                    setStatus("Status: All Bonds Collected! Teleporting to the Lobby...")
                    isTimerRunning = false
                    task.wait(1)
                    TeleportService:Teleport(116495829188952, LocalPlayer)
                    break
                end
            end
        end
    end
end

task.spawn(startAutoFarm)
