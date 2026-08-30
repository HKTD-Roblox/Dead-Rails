local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("ToraScript") then
    CoreGui.ToraScript:Destroy()
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LP = Players.LocalPlayer

local function getChar()
    return LP.Character or LP.CharacterAdded:Wait()
end

local function getHum(char)
    char = char or getChar()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getHRP(char)
    char = char or getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local loadedFn = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew",
    true
))()
local win = loadedFn:CreateWindow("Dead Rails")

_G.Gun = false
_G.Collect = false
_G.Speed = false
_G.FullBrightEnabled = false
_G.FullBrightExecuted = false
_G.InfJump = false

local noclipConn = nil
local infJumpConn = nil
local countdownSec = 600
local countdownLabel = nil

local function gunAuraOnce()
    local char = getChar()
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end

    local best, bestDist = nil, math.huge
    for _, d in ipairs(Workspace:GetDescendants()) do
        if d.Name == "HumanoidRootPart" and d.Parent and d:IsA("BasePart") then
            local model = d.Parent
            if model:GetAttribute("Bounty") and not model:GetAttribute("EntityName") then
                local hum = model:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local dist = LP:DistanceFromCharacter(d.Position)
                    if dist < bestDist then
                        bestDist = dist
                        best = d
                    end
                end
            end
        end
    end

    if not best then return end
    local targetHum = best.Parent:FindFirstChildOfClass("Humanoid")
    if not targetHum then return end

    local shootRemote = ReplicatedStorage:FindFirstChild("Remotes")
        and ReplicatedStorage.Remotes:FindFirstChild("Weapon")
        and ReplicatedStorage.Remotes.Weapon:FindFirstChild("Shoot")
    local reloadRemote = ReplicatedStorage:FindFirstChild("Remotes")
        and ReplicatedStorage.Remotes:FindFirstChild("Weapon")
        and ReplicatedStorage.Remotes.Weapon:FindFirstChild("Reload")

    if shootRemote then
        local hit = {
            ["2"] = targetHum,
            ["4"] = targetHum,
        }
        pcall(function()
            shootRemote:FireServer(
                Workspace:GetServerTimeNow(),
                tool,
                best.CFrame * CFrame.Angles(-1.794655442237854, 0.22748638689517975, 2.360928773880005),
                hit
            )
        end)
    end
    if reloadRemote then
        pcall(function()
            reloadRemote:FireServer(Workspace:GetServerTimeNow(), tool)
        end)
    end
end

local function startGun()
    task.spawn(function()
        while _G.Gun do
            pcall(gunAuraOnce)
            task.wait(0.2)
        end
    end)
end

local function startCollect()
    task.spawn(function()
        while _G.Collect do
            pcall(function()
                local folder = Workspace:FindFirstChild("RuntimeItems")
                if not folder then return end
                local remote = ReplicatedStorage:FindFirstChild("Shared")
                    and ReplicatedStorage.Shared:FindFirstChild("Network")
                    and ReplicatedStorage.Shared.Network:FindFirstChild("RemotePromise")
                    and ReplicatedStorage.Shared.Network.RemotePromise:FindFirstChild("Remotes")
                    and ReplicatedStorage.Shared.Network.RemotePromise.Remotes:FindFirstChild("C_ActivateObject")
                if not remote then return end
                for _, item in pairs(folder:GetChildren()) do
                    if not _G.Collect then break end
                    local text = item:GetAttribute("ActivateText")
                    if text == "Collect" or text == "Collect Bond" then
                        pcall(function()
                            remote:FireServer(item)
                        end)
                        task.wait(0.15)
                    end
                end
            end)
            task.wait(0.35)
        end
    end)
end

local function startSpeed()
    task.spawn(function()
        while _G.Speed do
            pcall(function()
                local hum = getHum()
                if hum then
                    hum.WalkSpeed = 18.5
                    Workspace.CurrentCamera.FieldOfView = 100
                end
            end)
            task.wait(3)
            if not _G.Speed then break end
            pcall(function()
                local hum = getHum()
                if hum then
                    hum.WalkSpeed = 16
                end
            end)
            task.wait(1)
        end
        pcall(function()
            local hum = getHum()
            if hum then
                hum.WalkSpeed = 16
            end
            Workspace.CurrentCamera.FieldOfView = 70
        end)
    end)
end

local function enableNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    noclipConn = RunService.Stepped:Connect(function()
        local char = LP.Character
        if not char then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

local function disableNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    local char = LP.Character
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.CanCollide = true
        end
    end
end

local function unlockCam()
    pcall(function()
        LP.CameraMode = Enum.CameraMode.Classic
        LP.CameraMinZoomDistance = 0
        LP.CameraMaxZoomDistance = 150
        local hum = getHum()
        if hum then
            Workspace.CurrentCamera.CameraSubject = hum
        end
    end)
end

local function applyFullBright(on)
    if on then
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 786543
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(178, 178, 178)
    end
end

local function setupFullBright()
    if _G.FullBrightExecuted then
        _G.FullBrightEnabled = not _G.FullBrightEnabled
        applyFullBright(_G.FullBrightEnabled)
        if not _G.FullBrightEnabled then
            Lighting.Brightness = 1
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        end
        return
    end
    _G.FullBrightExecuted = true
    _G.NormalLightingSettings = {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        FogEnd = Lighting.FogEnd,
        GlobalShadows = Lighting.GlobalShadows,
        Ambient = Lighting.Ambient,
    }
    _G.FullBrightEnabled = true
    applyFullBright(true)
    Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
        if _G.FullBrightEnabled and Lighting.Brightness ~= 1 then
            Lighting.Brightness = 1
        end
    end)
    Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
        if _G.FullBrightEnabled and Lighting.ClockTime ~= 12 then
            Lighting.ClockTime = 12
        end
    end)
    Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
        if _G.FullBrightEnabled and Lighting.FogEnd ~= 786543 then
            Lighting.FogEnd = 786543
        end
    end)
    Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
        if _G.FullBrightEnabled and Lighting.GlobalShadows ~= false then
            Lighting.GlobalShadows = false
        end
    end)
    Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
        if _G.FullBrightEnabled and Lighting.Ambient ~= Color3.fromRGB(178, 178, 178) then
            Lighting.Ambient = Color3.fromRGB(178, 178, 178)
        end
    end)
end

local function startCountdown()
    task.spawn(function()
        while countdownSec > 0 do
            if countdownLabel and countdownLabel.Parent then
                countdownLabel.Text = string.format(
                    "%02d:%02d",
                    math.floor(countdownSec / 60),
                    countdownSec % 60
                )
            end
            task.wait(1)
            countdownSec = countdownSec - 1
        end
        if countdownLabel and countdownLabel.Parent then
            countdownLabel.Text = "00:00"
        end
    end)
end

local oldIndex
pcall(function()
    oldIndex = hookmetamethod(game, "__index", function(self, key)
        if not checkcaller() then
            local name = tostring(self)
            if key == "Value" then
                if name == "FireDelay" or name:find("FireDelay") then
                    return 0
                end
                if name == "ReloadDuration" or name:find("ReloadDuration") then
                    return 0
                end
                if name == "SpreadAngle" or name:find("SpreadAngle") then
                    return 0
                end
                if name == "MagazineSize" or name:find("MagazineSize") then
                    return math.huge
                end
            end
        end
        return oldIndex(self, key)
    end)
end)

win:AddButton({
    text = "Teleport to End",
    flag = "btn_end",
    callback = function()
        task.spawn(function()
            local t = tick()
            while tick() - t < 5 do
                local hrp = getHRP()
                local hum = getHum()
                if hrp and hum and not hum.Sit then
                    hrp.CFrame = CFrame.new(-428.745911, 28.0728378, -49040.9062)
                end
                task.wait()
            end
        end)
    end,
})

win:AddButton({
    text = "Teleport to Train",
    flag = "btn_train",
    callback = function()
        task.spawn(function()
            local seat = nil
            for _, model in pairs(Workspace:GetChildren()) do
                if model:IsA("Model") and model:GetAttribute("serverEntityId") then
                    for _, d in pairs(model:GetDescendants()) do
                        if d.Name == "VehicleSeat" or d:IsA("VehicleSeat") then
                            seat = d
                            break
                        end
                    end
                end
                if seat then break end
            end
            if not seat then return end
            local t = tick()
            while tick() - t < 5 do
                local hrp = getHRP()
                local hum = getHum()
                if hrp and hum and not hum.Sit then
                    hrp.CFrame = CFrame.new(seat.Position)
                end
                task.wait()
            end
        end)
    end,
})

win:AddToggle({
    text = "Gun Aura (Kill Mobs)",
    flag = "toggle_gun",
    state = false,
    callback = function(on)
        _G.Gun = on
        if on then
            startGun()
        end
    end,
})

win:AddToggle({
    text = "Collect Bond & Ammo",
    flag = "toggle_collect",
    state = false,
    callback = function(on)
        _G.Collect = on
        if on then
            startCollect()
        end
    end,
})

win:AddToggle({
    text = "Walk Speed",
    flag = "toggle_speed",
    state = false,
    callback = function(on)
        _G.Speed = on
        if on then
            startSpeed()
        else
            pcall(function()
                local hum = getHum()
                if hum then
                    hum.WalkSpeed = 16
                end
                Workspace.CurrentCamera.FieldOfView = 70
            end)
        end
    end,
})

win:AddToggle({
    text = "Noclip",
    flag = "toggle_noclip",
    state = false,
    callback = function(on)
        if on then
            enableNoclip()
        else
            disableNoclip()
        end
    end,
})

win:AddButton({
    text = "UnlockCam",
    flag = "btn_cam",
    callback = function()
        unlockCam()
    end,
})

win:AddButton({
    text = "FullBright",
    flag = "btn_bright",
    callback = function()
        setupFullBright()
    end,
})

win:AddButton({
    text = "Inf Jump",
    flag = "btn_jump",
    callback = function()
        if infJumpConn then
            infJumpConn:Disconnect()
            infJumpConn = nil
            _G.InfJump = false
            return
        end
        _G.InfJump = true
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            if not _G.InfJump then return end
            local hum = getHum()
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end,
})

win:AddBox({
    text = "Countdown",
    flag = "box_countdown",
    value = "600",
    callback = function(val)
        local n = tonumber(val)
        if n and n > 0 then
            countdownSec = math.floor(n)
        end
    end,
})

win:AddLabel({
    text = "Make by HKTD Roblox",
})

loadedFn:Init()

task.defer(function()
    task.wait(0.5)
    pcall(function()
        local gui = CoreGui:FindFirstChild("ToraScript")
        if gui then
            local ib = gui:FindFirstChild("ImageButton")
            local fr = ib and ib:FindFirstChild("Frame")
            local fr2 = fr and fr:FindFirstChild("Frame")
            local tb = fr2 and fr2:FindFirstChild("TextBox")
            if tb then
                countdownLabel = tb
                startCountdown()
            end
        end
    end)
end)
