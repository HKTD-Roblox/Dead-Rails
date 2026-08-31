local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Clean UI cũ nếu đã tồn tại
if CoreGui:FindFirstChild("ToraScript") then
    CoreGui.ToraScript:Destroy()
end

-- Reset trạng thái biến về Off khi mới bật
_G.Gun = false
_G.Collect = false
_G.UnlockCam = false

-- Tải UI Library
local loadedFn = loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew", true))()
local Window = loadedFn:CreateWindow("Dead Rails")

local noclipConnection = nil

-- Hàm hỗ trợ lấy Character
local function getCharacter()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char, char:WaitForChild("HumanoidRootPart", 5), char:WaitForChild("Humanoid", 5)
end

---------------------------------------------------------
-- BUTTONS
---------------------------------------------------------

Window:AddButton({
    text = "Teleport to End",
    flag = "END",
    callback = function()
        local _, hrp, hum = getCharacter()
        if hrp and hum and not hum.Sit then
            hrp.CFrame = CFrame.new(-428.745911, 28.0728378, -49040.9062)
        end
    end,
})

Window:AddButton({
    text = "Teleport to Train",
    flag = "Train",
    callback = function()
        local _, hrp = getCharacter()
        if not hrp then return end

        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and model:GetAttribute("serverEntityId") then
                local seat = model:FindFirstChildWhichIsA("VehicleSeat", true)
                if seat then
                    hrp.CFrame = seat.CFrame * CFrame.new(0, 3, 0)
                    break
                end
            end
        end
    end,
})

---------------------------------------------------------
-- TOGGLES (MẶC ĐỊNH OFF)
---------------------------------------------------------

-- 1. Gun Aura Toggle
local function runGunAura()
    for _, v2 in ipairs(workspace:GetDescendants()) do
        if v2.Name == "HumanoidRootPart" and v2.Parent then
            if not v2.Parent:GetAttribute("EntityName") and v2.Parent:GetAttribute("Bounty") then
                local hum = v2.Parent:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 then
                    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool and ReplicatedStorage:FindFirstChild("Remotes") then
                        pcall(function()
                            ReplicatedStorage.Remotes.Weapon.Shoot:FireServer()
                            ReplicatedStorage.Remotes.Weapon.Reload:FireServer()
                        end)
                    end
                end
            end
        end
    end
end

Window:AddToggle({
    text = "Gun Aura (Kill Mobs)",
    flag = "toggle_gun",
    state = false,
    callback = function(state)
        _G.Gun = state
        if state then
            task.spawn(function()
                while _G.Gun do
                    runGunAura()
                    task.wait(0.2)
                end
            end)
        end
    end,
})

-- 2. Collect Bond & Ammo Toggle
Window:AddToggle({
    text = "Collect Bond & Ammo",
    flag = "toggle_collect",
    state = false,
    callback = function(state)
        _G.Collect = state
        if state then
            task.spawn(function()
                while _G.Collect do
                    if workspace:FindFirstChild("RuntimeItems") then
                        for _, item in pairs(workspace.RuntimeItems:GetChildren()) do
                            if item:GetAttribute("ActivateText") == "Collect" or item:GetAttribute("ActivateText") == "Collect Bond" then
                                pcall(function()
                                    ReplicatedStorage.Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer(item)
                                end)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end,
})

-- 3. Unlock Cam Toggle
Window:AddToggle({
    text = "UnlockCam",
    flag = "toggle_cam",
    state = false,
    callback = function(state)
        _G.UnlockCam = state
        if state then
            LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 500
        else
            LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 12.5
        end
    end,
})

-- 4. Noclip Toggle
Window:AddToggle({
    text = "Noclip",
    flag = "toggle_noclip",
    state = false,
    callback = function(state)
        if state then
            noclipConnection = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
        end
    end,
})

---------------------------------------------------------
-- COUNTDOWN BOX (KHÓA TƯƠNG TÁC TẠO HIỆU ỨNG READ-ONLY)
---------------------------------------------------------

local countdownBox = Window:AddBox({
    text = "Countdown",
    value = "10:00",
    callback = function() end,
})

-- Khóa cứng tương tác ngay sau khi khởi tạo Box
task.spawn(function()
    task.wait(0.1)
    local toraGui = CoreGui:FindFirstChild("ToraScript")
    if toraGui then
        for _, obj in ipairs(toraGui:GetDescendants()) do
            if obj:IsA("TextBox") then
                obj.TextEditable = false
                obj.ClearTextOnFocus = false
                obj.Active = false
            end
        end
    end
end)

-- Luồng đếm ngược
task.spawn(function()
    local timeLeft = 600
    while timeLeft > 0 do
        local mins = math.floor(timeLeft / 60)
        local secs = timeLeft % 60
        local strTime = string.format("%02d:%02d", mins, secs)
        
        pcall(function()
            if countdownBox and countdownBox.Set then
                countdownBox:Set(strTime)
            end
        end)

        task.wait(1)
        timeLeft = timeLeft - 1
    end

    pcall(function()
        if countdownBox and countdownBox.Set then
            countdownBox:Set("Time's Up!")
        end
    end)
end)

---------------------------------------------------------
-- LABEL FOOTER
---------------------------------------------------------

Window:AddLabel({
    text = "Make by HKTD Roblox",
})

-- Khởi chạy UI
loadedFn:Init()
