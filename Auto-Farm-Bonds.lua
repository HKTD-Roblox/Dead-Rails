local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

local TARGET_PLACE = 116495829188952
if game.PlaceId ~= TARGET_PLACE then
    LocalPlayer:Kick("This script can only be used in Dead Rails.")
    return
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HKTDRoblox_DeadRails"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = (CoreGui:FindFirstChild("RobloxGui") or CoreGui)

local function makeCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
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
        if btn and btn.Parent then
            btn.Text = "Copy Discord"
        end
    end)
end

CopyBtn.MouseButton1Click:Connect(function() handleDiscordCopy(CopyBtn) end)
CreditCopyBtn.MouseButton1Click:Connect(function() handleDiscordCopy(CreditCopyBtn) end)
CreditBtn.MouseButton1Click:Connect(function() CreditFrame.Visible = true end)
CreditOkBtn.MouseButton1Click:Connect(function() CreditFrame.Visible = false end)

local elapsedSeconds = 0
local isTimerRunning = false
local bondCount = 0

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

local function setStatus(s)
    StatusText.Text = s
end

local function getChar()
    return LocalPlayer.Character
end

local function getHRP()
    local c = getChar()
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function getHum()
    local c = getChar()
    return c and c:FindFirstChildOfClass("Humanoid")
end

local JOIN_KEYWORDS = {
    "solo", "1/1", "1 / 1", "play", "start", "join", "ready", "go", "begin",
    "create", "quick", "match", "deploy", "embark", "board", "enter"
}

-- CHỈ GIỮ LẠI TỪ KHÓA LIÊN QUAN ĐẾN BONDS (ĐÃ LỌC BỎ CHUNG CHUNG)
local BOND_KEYWORDS = {
    "bond", "bonds", "cashbond", "bondpickup", "bonditem", "collectbond"
}

local function textHasAny(str, list)
    str = string.lower(tostring(str or ""))
    for _, k in ipairs(list) do
        if string.find(str, k, 1, true) then
            return true
        end
    end
    return false
end

local function safeFirePrompt(prompt)
    if not prompt then return false end
    local ok = false
    pcall(function()
        if fireproximityprompt then
            fireproximityprompt(prompt)
            ok = true
        end
    end)
    pcall(function()
        if fireproximityprompt then
            fireproximityprompt(prompt, 1)
            ok = true
        end
    end)
    pcall(function()
        prompt.HoldDuration = 0
        prompt.MaxActivationDistance = 999
        prompt.RequiresLineOfSight = false
        if fireproximityprompt then
            fireproximityprompt(prompt)
            ok = true
        end
    end)
    return ok
end

local function safeTouch(part)
    local hrp = getHRP()
    if not hrp or not part then return end
    pcall(function()
        if firetouchinterest then
            firetouchinterest(hrp, part, 0)
            task.wait(0.03)
            firetouchinterest(hrp, part, 1)
        end
    end)
end

local function clickGuiButton(btn)
    if not btn then return end
    pcall(function()
        if firesignal then
            if btn.MouseButton1Click then firesignal(btn.MouseButton1Click) end
            if btn.Activated then firesignal(btn.Activated) end
            if btn.MouseButton1Down then firesignal(btn.MouseButton1Down) end
            if btn.MouseButton1Up then firesignal(btn.MouseButton1Up) end
        end
    end)
    pcall(function()
        if btn.Activate then btn:Activate() end
    end)
end

local function isPlayerInLobby()
    local score = 0
    if workspace:FindFirstChild("Lobby") then score += 2 end
    if workspace:FindFirstChild("LobbyMap") then score += 2 end
    if workspace:FindFirstChild("LobbySpawn") then score += 2 end
    if workspace:FindFirstChild("Menu") then score += 1 end
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg then
        for _, n in ipairs({"LobbyGui", "MainMenu", "Lobby", "Menu", "TitleScreen", "PlayGui", "StartGui"}) do
            if pg:FindFirstChild(n, true) then score += 2 end
        end
    end
    if workspace:FindFirstChild("RuntimeItems") then score -= 3 end
    if workspace:FindFirstChild("Map") then score -= 2 end
    if workspace:FindFirstChild("Game") then score -= 2 end
    if workspace:FindFirstChild("Train") then score -= 2 end
    if workspace:FindFirstChild("Bonds") then score -= 2 end
    for _, o in ipairs(workspace:GetChildren()) do
        if o:IsA("Model") and o:GetAttribute("serverEntityId") then
            score -= 2
            break
        end
    end
    return score > 0
end

local function findJoinPrompts()
    local found = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local blob = string.lower(tostring(v.ObjectText) .. " " .. tostring(v.ActionText) .. " " .. tostring(v.Name) .. " " .. tostring(v.Parent and v.Parent.Name))
            if textHasAny(blob, JOIN_KEYWORDS) then
                table.insert(found, v)
            end
        end
    end
    return found
end

local function findJoinParts()
    local found = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local n = string.lower(v.Name)
            local p = v.Parent and string.lower(v.Parent.Name) or ""
            if textHasAny(n .. " " .. p, JOIN_KEYWORDS) and not string.find(n, "gui", 1, true) then
                table.insert(found, v)
            end
        end
    end
    return found
end

local function findJoinGuiButtons()
    local found = {}
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return found end
    for _, v in ipairs(pg:GetDescendants()) do
        if v:IsA("TextButton") or v:IsA("ImageButton") then
            local t = string.lower(tostring(v.Text) .. " " .. tostring(v.Name))
            if textHasAny(t, JOIN_KEYWORDS) then
                table.insert(found, v)
            end
        end
    end
    return found
end

local function fireJoinRemotes()
    local names = {"Play", "Start", "Join", "Solo", "Create", "QuickJoin", "StartGame", "JoinGame", "Enter", "Deploy"}
    local function tryRemote(r)
        if not r then return end
        if r:IsA("RemoteEvent") then
            pcall(function() r:FireServer() end)
            pcall(function() r:FireServer(true) end)
            pcall(function() r:FireServer("Solo") end)
            pcall(function() r:FireServer(1) end)
            pcall(function() r:FireServer({Solo = true}) end)
        elseif r:IsA("RemoteFunction") then
            pcall(function() r:InvokeServer() end)
            pcall(function() r:InvokeServer(true) end)
            pcall(function() r:InvokeServer("Solo") end)
        end
    end
    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
        if r:IsA("RemoteEvent") or r:IsA("RemoteFunction") then
            local n = string.lower(r.Name)
            for _, key in ipairs(names) do
                if string.find(n, string.lower(key), 1, true) then
                    tryRemote(r)
                end
            end
        end
    end
end

local function enterSoloGame()
    local hrp = getHRP()
    for _, prompt in ipairs(findJoinPrompts()) do
        if hrp and prompt.Parent then
            local part = prompt.Parent:IsA("BasePart") and prompt.Parent or prompt.Parent:FindFirstChildWhichIsA("BasePart")
            if part then
                pcall(function() hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0) end)
            end
        end
        safeFirePrompt(prompt)
        task.wait(0.15)
    end
    for _, part in ipairs(findJoinParts()) do
        if hrp then
            pcall(function() hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0) end)
            safeTouch(part)
            local prompt = part:FindFirstChildWhichIsA("ProximityPrompt", true)
                or (part.Parent and part.Parent:FindFirstChildWhichIsA("ProximityPrompt", true))
            safeFirePrompt(prompt)
        end
        task.wait(0.1)
    end
    for _, btn in ipairs(findJoinGuiButtons()) do
        clickGuiButton(btn)
        task.wait(0.05)
    end
    fireJoinRemotes()
end

-- LỌC CHÍNH XÁC CHỈ LẤY BONDS (BỎ QUA AMMO)
local function isBondObject(obj)
    if not obj or not obj.Parent then return false end
    local n = string.lower(obj.Name)
    if textHasAny(n, BOND_KEYWORDS) then return true end
    
    local ok, attrs = pcall(function() return obj:GetAttributes() end)
    if ok and attrs then
        for k, v in pairs(attrs) do
            local blob = string.lower(tostring(k) .. " " .. tostring(v))
            if textHasAny(blob, BOND_KEYWORDS) then
                return true
            end
        end
    end
    
    local at = nil
    pcall(function() at = obj:GetAttribute("ActivateText") end)
    if at and (string.lower(tostring(at)) == "collect bond" or textHasAny(at, BOND_KEYWORDS)) then
        return true
    end
    return false
end

local function getBondPart(obj)
    if obj:IsA("BasePart") then return obj end
    if obj:IsA("Model") then
        if obj.PrimaryPart then return obj.PrimaryPart end
        return obj:FindFirstChildWhichIsA("BasePart", true)
    end
    return obj:FindFirstChildWhichIsA("BasePart", true)
end

local function scanAllBonds()
    local list = {}
    local folders = {
        workspace:FindFirstChild("RuntimeItems"),
        workspace:FindFirstChild("Items"),
        workspace:FindFirstChild("Bonds"),
        workspace:FindFirstChild("Pickups"),
        workspace:FindFirstChild("Loot"),
        workspace,
    }
    local seen = {}
    for _, root in ipairs(folders) do
        if root then
            local ok, descs = pcall(function() return root:GetDescendants() end)
            if ok then
                for _, obj in ipairs(descs) do
                    if isBondObject(obj) then
                        local main = obj
                        if obj:IsA("BasePart") and obj.Parent and obj.Parent:IsA("Model") and isBondObject(obj.Parent) then
                            main = obj.Parent
                        end
                        if not seen[main] then
                            local part = getBondPart(main)
                            if part then
                                seen[main] = true
                                table.insert(list, {obj = main, part = part})
                            end
                        end
                    end
                end
            end
        end
    end
    return list
end

local function fireCollectRemotes(target)
    local keys = {"Activate", "Collect", "Pickup", "Interact", "Use", "Claim", "Loot", "Bond"}
    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
        if r:IsA("RemoteEvent") then
            local n = string.lower(r.Name)
            for _, k in ipairs(keys) do
                if string.find(n, string.lower(k), 1, true) then
                    pcall(function() r:FireServer(target) end)
                    pcall(function() r:FireServer() end)
                    pcall(function() r:FireServer(target, true) end)
                end
            end
        end
    end
    pcall(function()
        local shared = ReplicatedStorage:FindFirstChild("Shared")
        local net = shared and shared:FindFirstChild("Network")
        local rp = net and net:FindFirstChild("RemotePromise")
        local rems = rp and rp:FindFirstChild("Remotes")
        if rems then
            for _, r in ipairs(rems:GetChildren()) do
                if r:IsA("RemoteEvent") then
                    local n = string.lower(r.Name)
                    if string.find(n, "activate", 1, true) or string.find(n, "collect", 1, true) or string.find(n, "object", 1, true) then
                        pcall(function() r:FireServer(target) end)
                        pcall(function() r:FireServer() end)
                    end
                end
            end
        end
    end)
end

-- LOGIC MỚI: DỊCH CHUYỂN BOND VỀ TRƯỚC MẶT PLAYER
local function collectOneBond(bondObj, bondPart)
    local hrp = getHRP()
    if not hrp or not bondPart or not bondPart.Parent then return false end
    local beforeParent = bondObj.Parent

    -- TÍNH TOÁN VỊ TRÍ TRƯỚC MẶT PLAYER (Cách 3 studs)
    local targetCFrame = hrp.CFrame * CFrame.new(0, 0, -3)

    -- Dịch chuyển Bond đến vị trí tính toán
    pcall(function()
        if bondObj:IsA("Model") then
            bondObj:PivotTo(targetCFrame)
        else
            bondPart.CFrame = targetCFrame
        end
    end)

    -- Triệt tiêu lực vật lý tránh làm Bond rơi lung tung
    pcall(function()
        bondPart.AssemblyLinearVelocity = Vector3.zero
        bondPart.AssemblyAngularVelocity = Vector3.zero
    end)

    task.wait(0.03)

    -- Gửi các tín hiệu tương tác nhặt đồ
    local prompt = bondObj:FindFirstChildWhichIsA("ProximityPrompt", true)
        or bondPart:FindFirstChildWhichIsA("ProximityPrompt", true)
    safeFirePrompt(prompt)
    safeTouch(bondPart)
    fireCollectRemotes(bondObj)
    fireCollectRemotes(bondPart)

    task.wait(0.05)
    if not bondObj.Parent or bondObj.Parent ~= beforeParent then
        return true
    end
    return false
end

local function farmBondsPass()
    local bonds = scanAllBonds()
    if #bonds == 0 then
        return 0
    end
    local got = 0
    for _, b in ipairs(bonds) do
        if isPlayerInLobby() then break end
        if b.obj and b.obj.Parent and b.part and b.part.Parent then
            local success = false
            for _ = 1, 6 do
                if not b.obj.Parent or isPlayerInLobby() then break end
                if collectOneBond(b.obj, b.part) then
                    success = true
                    break
                end
                task.wait(0.03)
            end
            if success or not b.obj.Parent then
                got += 1
                bondCount += 1
                BondsText.Text = string.format("Bonds: %02d", bondCount)
            end
        end
        task.wait(0.03)
    end
    return got
end

local function teleportLobby()
    setStatus("Status: All Bonds Collected! Teleporting to the Lobby...")
    isTimerRunning = false
    task.wait(0.5)
    pcall(function()
        TeleportService:Teleport(TARGET_PLACE, LocalPlayer)
    end)
    local t = tick()
    repeat
        task.wait(0.5)
    until isPlayerInLobby() or tick() - t > 25
end

local function startAutoFarm()
    while true do
        task.wait(0.15)
        local ok, err = pcall(function()
            if isPlayerInLobby() then
                isTimerRunning = false
                setStatus("Status: Joining the Game...")
                enterSoloGame()
                task.wait(1.2)
            else
                isTimerRunning = true
                setStatus("Status: Getting All Bonds...")
                local collected = farmBondsPass()
                if collected == 0 then
                    local empty = 0
                    for _ = 1, 4 do
                        task.wait(0.35)
                        if isPlayerInLobby() then return end
                        if #scanAllBonds() == 0 then
                            empty += 1
                        else
                            empty = 0
                            break
                        end
                    end
                    if empty >= 4 and not isPlayerInLobby() then
                        teleportLobby()
                    end
                end
            end
        end)
        if not ok then
            setStatus("Status: Error, retrying...")
            task.wait(1)
        end
    end
end

task.spawn(startAutoFarm)
