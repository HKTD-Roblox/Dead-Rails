local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("ToraScript") then
    local CoreGui2 = game:GetService("CoreGui")
    CoreGui2.ToraScript:Destroy()
end

local loadedFn = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew",
    true
))()

local v = loadedFn:CreateWindow("Dead Rails")

--==================================================
-- TP TO END
--==================================================

v:AddButton({
    text = "TP to End",
    flag = "END",
    callback = function()
        local localPlayer = game.Players.LocalPlayer.Character

        while true do
            if not localPlayer:WaitForChild("Humanoid").Sit then
                localPlayer:WaitForChild("HumanoidRootPart").CFrame =
                    CFrame.new(-428.745911, 28.0728378, -49040.9062)

                task.wait()
            end
        end
    end,
})

--==================================================
-- TP TO TRAIN
--==================================================

v:AddButton({
    text = "TP to Train",
    flag = "Train",
    callback = function(...)
        local localPlayer = game.Players.LocalPlayer.Character

        for _, v2 in pairs(workspace:GetChildren()) do
            if v2:IsA("Model") and v2:GetAttribute("serverEntityId") then

                for _, v4 in pairs(v2:GetDescendants()) do
                    if v4.Name == "VehicleSeat" then

                        while true do
                            if not localPlayer:WaitForChild("Humanoid").Sit then
                                localPlayer:WaitForChild("HumanoidRootPart").CFrame =
                                    CFrame.new(v4.Position)

                                task.wait()
                            end
                        end

                    end
                end

            end
        end
    end,
})

--==================================================
-- GUN AURA
--==================================================

v:AddToggle({
    text = "Gun Aura (Kill Mobs)",
    flag = "toggle",
    state = false,
    callback = function(p0)
        _G.Gun = p0
        print("Gun: ", p0)

        if p0 then
            Gun()
        end
    end,
})

Gun = function()
    spawn(function()
        _G.Gun = true

        while true do
            if _G.Gun then
                wait()

                pcall(function()
                    local Players = game:GetService("Players")
                    local _upv0 = Players.LocalPlayer

                    func_b1b7f2ce()

                    wait(0.2)
                end)
            end
        end
    end)
end

--==================================================
-- COLLECT BOND & AMMO
--==================================================

v:AddToggle({
    text = "Collect Bond & Ammo",
    flag = "toggle",
    state = false,
    callback = function(p0)
        _G.Collect = p0
        print("Collect: ", p0)

        if p0 then
            Collect()
        end
    end,
})

Collect = function()
    spawn(function()
        _G.Collect = true

        while true do
            if _G.Collect then
                wait()

                pcall(function(...)
                    for _, v2 in pairs(workspace.RuntimeItems:GetChildren()) do

                        if v2:GetAttribute("ActivateText") ~= "Collect Bond"
                            and v2:GetAttribute("ActivateText") == "Collect" then

                            local config = {}
                            config[1] = v2

                            local ReplicatedStorage =
                                game:GetService("ReplicatedStorage")

                            ReplicatedStorage.Shared.Network.RemotePromise.Remotes.C_ActivateObject:FireServer()
                        end

                        wait(1)

                        return
                    end
                end)
            end
        end
    end)
end

--==================================================
-- WALK SPEED
--==================================================

v:AddToggle({
    text = "Walk Speed",
    flag = "toggle",
    state = false,

    callback = function(p0)
        _G.Speed = p0
        print("Speed: ", p0)

        local localPlayer = game.Players.LocalPlayer
        local v

        if localPlayer.Character then
            v = localPlayer.Character:FindFirstChild("Humanoid")
        end

        if p0 then
            _G.Speed = true

            task.spawn(function()
                while true do

                    if _G.Speed then

                        pcall(function()
                            if v then
                                v.WalkSpeed = 18.5
                                workspace.CurrentCamera.FieldOfView = 100
                            end
                        end)

                        task.wait(3)

                        pcall(function()
                            if v then
                                v.WalkSpeed = 16
                            end
                        end)

                        task.wait(1)
                    end
                end
            end)

        else
            _G.Speed = false

            pcall(function()
                if v then
                    v.WalkSpeed = 16
                    workspace.CurrentCamera.FieldOfView = 70
                end
            end)
        end
    end,
})

--==================================================
-- NOCLIP
--==================================================

local v4 = nil
local v5 = nil

noclip = function(...)
    v5 = false

    local RunService = game:GetService("RunService")

    v4 = RunService.Stepped:Connect(function(...)
        if not v5 and game.Players.LocalPlayer.Character then

            for _, v2 in pairs(
                game.Players.LocalPlayer.Character:GetDescendants()
            ) do

                if v2:IsA("BasePart") and v2.CanCollide then
                    v2.CanCollide = false
                end

            end
        end

        wait(0.21)
    end)
end

clip = function(...)
    if v4 then
        v4:Disconnect()
    end

    v5 = true
end

v:AddToggle({
    text = "Noclip",
    flag = "toggle_noclip",
    state = false,

    callback = function(p0)
        if p0 then
            noclip()
        else
            clip()
        end
    end,
})

--==================================================
-- UNLOCK CAM
--==================================================

v:AddButton({
    text = "UnlockCam",
    flag = "button",

    callback = function()
        local _upv0 = game.Players.LocalPlayer
        local _upv1 = workspace.CurrentCamera

        func_2b6fb775()
    end,
})

--==================================================
-- FULL BRIGHT
--==================================================

v:AddButton({
    text = "FullBright",
    flag = "button",

    callback = function()

        if not _G.FullBrightExecuted then

            _G.FullBrightEnabled = false

            local config = {}

            local Lighting = game:GetService("Lighting")
            config.Brightness = Lighting.Brightness

            local Lighting2 = game:GetService("Lighting")
            config.ClockTime = Lighting2.ClockTime

            local Lighting3 = game:GetService("Lighting")
            config.FogEnd = Lighting3.FogEnd

            local Lighting4 = game:GetService("Lighting")
            config.GlobalShadows = Lighting4.GlobalShadows

            local Lighting5 = game:GetService("Lighting")
            config.Ambient = Lighting5.Ambient

            _G.NormalLightingSettings = config

            local Lighting6 = game:GetService("Lighting")

            Lighting6:GetPropertyChangedSignal("Brightness"):Connect(function()

                local Lighting = game:GetService("Lighting")

                if Lighting.Brightness ~= 1 then

                    local Lighting2 = game:GetService("Lighting")

                    if Lighting2.Brightness ~= _G.NormalLightingSettings.Brightness then

                        local Lighting3 = game:GetService("Lighting")
                        _G.NormalLightingSettings.Brightness =
                            Lighting3.Brightness

                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end

                        local Lighting4 = game:GetService("Lighting")
                        Lighting4.Brightness = 1
                    end
                end
            end)

            local Lighting7 = game:GetService("Lighting")

            Lighting7:GetPropertyChangedSignal("ClockTime"):Connect(function()

                local Lighting = game:GetService("Lighting")

                if Lighting.ClockTime ~= 12 then

                    local Lighting2 = game:GetService("Lighting")

                    if Lighting2.ClockTime ~= _G.NormalLightingSettings.ClockTime then

                        local Lighting3 = game:GetService("Lighting")
                        _G.NormalLightingSettings.ClockTime =
                            Lighting3.ClockTime

                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end

                        local Lighting4 = game:GetService("Lighting")
                        Lighting4.ClockTime = 12
                    end
                end
            end)

            local Lighting8 = game:GetService("Lighting")

            Lighting8:GetPropertyChangedSignal("FogEnd"):Connect(function()

                local Lighting = game:GetService("Lighting")

                if Lighting.FogEnd ~= 786543 then

                    local Lighting2 = game:GetService("Lighting")

                    if Lighting2.FogEnd ~= _G.NormalLightingSettings.FogEnd then

                        local Lighting3 = game:GetService("Lighting")
                        _G.NormalLightingSettings.FogEnd =
                            Lighting3.FogEnd

                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end

                        local Lighting4 = game:GetService("Lighting")
                        Lighting4.FogEnd = 786543
                    end
                end
            end)

            local Lighting9 = game:GetService("Lighting")

            Lighting9:GetPropertyChangedSignal("GlobalShadows"):Connect(function()

                local Lighting = game:GetService("Lighting")

                if Lighting.GlobalShadows ~= false then

                    local Lighting2 = game:GetService("Lighting")

                    if Lighting2.GlobalShadows ~=
                        _G.NormalLightingSettings.GlobalShadows then

                        local Lighting3 = game:GetService("Lighting")
                        _G.NormalLightingSettings.GlobalShadows =
                            Lighting3.GlobalShadows

                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end

                        local Lighting4 = game:GetService("Lighting")
                        Lighting4.GlobalShadows = false
                    end
                end
            end)

            local Lighting10 = game:GetService("Lighting")

            Lighting10:GetPropertyChangedSignal("Ambient"):Connect(function()

                local Lighting = game:GetService("Lighting")

                if Lighting.Ambient ~= Color3.fromRGB(178, 178, 178) then

                    local Lighting2 = game:GetService("Lighting")

                    if Lighting2.Ambient ~=
                        _G.NormalLightingSettings.Ambient then

                        local Lighting3 = game:GetService("Lighting")
                        _G.NormalLightingSettings.Ambient =
                            Lighting3.Ambient

                        if not _G.FullBrightEnabled then
                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end

                        local Lighting4 = game:GetService("Lighting")
                        Lighting4.Ambient =
                            Color3.fromRGB(178, 178, 178)
                    end
                end
            end)

            local Lighting11 = game:GetService("Lighting")
            Lighting11.Brightness = 1

            local Lighting12 = game:GetService("Lighting")
            Lighting12.ClockTime = 12

            local Lighting13 = game:GetService("Lighting")
            Lighting13.FogEnd = 786543

            local Lighting14 = game:GetService("Lighting")
            Lighting14.GlobalShadows = false

            local Lighting15 = game:GetService("Lighting")
            Lighting15.Ambient = Color3.fromRGB(178, 178, 178)

            local _upv0 = true

            spawn(function()

                repeat
                    wait()
                until _G.FullBrightEnabled

                while true do

                    if not _G.FullBrightEnabled then

                        local Lighting = game:GetService("Lighting")
                        Lighting.Brightness =
                            _G.NormalLightingSettings.Brightness

                        local Lighting2 = game:GetService("Lighting")
                        Lighting2.ClockTime =
                            _G.NormalLightingSettings.ClockTime

                        local Lighting3 = game:GetService("Lighting")
                        Lighting3.FogEnd =
                            _G.NormalLightingSettings.FogEnd

                        local Lighting4 = game:GetService("Lighting")
                        Lighting4.GlobalShadows =
                            _G.NormalLightingSettings.GlobalShadows

                        local Lighting5 = game:GetService("Lighting")
                        Lighting5.Ambient =
                            _G.NormalLightingSettings.Ambient

                    else

                        local Lighting6 = game:GetService("Lighting")
                        Lighting6.Brightness = 1

                        local Lighting7 = game:GetService("Lighting")
                        Lighting7.ClockTime = 12

                        local Lighting8 = game:GetService("Lighting")
                        Lighting8.FogEnd = 786543

                        local Lighting9 = game:GetService("Lighting")
                        Lighting9.GlobalShadows = false

                        local Lighting10 = game:GetService("Lighting")
                        Lighting10.Ambient =
                            Color3.fromRGB(178, 178, 178)
                    end

                    _upv0 = not _upv0
                end
            end)
        end

        _G.FullBrightExecuted = false
        _G.FullBrightEnabled = not _G.FullBrightEnabled
    end,
})

--==================================================
-- INFINITE JUMP
--==================================================

v:AddButton({
    text = "Inf Jump",
    flag = "button",

    callback = function()
        local UserInputService =
            game:GetService("UserInputService")

        UserInputService.JumpRequest:Connect(function()
            game.Players.LocalPlayer.Character
                :FindFirstChildOfClass("Humanoid")
                :ChangeState("Jumping")
        end)
    end,
})

--==================================================
-- COUNTDOWN
--==================================================

v:AddBox({
    text = "Countdown",
    flag = "box",
    value = "Set Speed",

    callback = function(p0)
    end,
})

v:AddLabel({
    text = "Make by HKTD Roblox",
})

--==================================================
-- INIT
--==================================================

loadedFn:Init()

--==================================================
-- COUNTDOWN LOGIC
--==================================================

local CoreGui3 = game:GetService("CoreGui")
local _upv0 = 600
local _upv1 = CoreGui3.ToraScript.ImageButton.Frame.Frame.TextBox

func_cc7c4015()

--==================================================
-- WEAPON MODIFIER
--==================================================

local _upv0 = nil

local function func_cc7c4015()

    while true do

        if 0 < _upv0 then
            _upv1.Text = string.format(
                "%02d:%02d",
                math.floor(_upv0 / 60),
                _upv0 % 60
            )

            wait(1)

            _upv0 = _upv0 - 1
        end
    end

    _upv1.Text = "00:00"

    return
end

local function func_aa65d143(p0, p1)

    if not checkcaller() then

        local v = tostring(p0)

        if v == "FireDelay" and p1 == "Value" then
            return 0
        end

        if v == "MagazineSize" and p1 == "Value" then
            return math.huge
        end

        if v == "ReloadDuration" and p1 == "Value" then
            return 0
        end

        if v == "SpreadAngle" and p1 == "Value" then
            return 0
        end
    end

    return _upv0
end

--==================================================
-- GUN AURA LOGIC
--==================================================

local function func_b1b7f2ce(...)

    for _, v2 in ipairs(workspace:GetDescendants()) do

        if v2.Name == "HumanoidRootPart" then

            if not v2.Parent:GetAttribute("EntityName")
                and v2.Name == "HumanoidRootPart"
                and v2.Parent:GetAttribute("Bounty") then

                local v3 = v2.Parent:FindFirstChild("Humanoid")

                if v3 and 0 < v3.Health then

                    local v4 =
                        game.Players.LocalPlayer:
                        DistanceFromCharacter(v2.Position)

                    if v4 < math.huge then
                        local v5 = v2
                    end
                end
            end

            if v5 then

                local config = {}

                config[1] = workspace:GetServerTimeNow()

                config[2] =
                    game.Players.LocalPlayer.Character:
                    FindFirstChildOfClass("Tool")

                config[3] =
                    v5.CFrame *
                    CFrame.Angles(
                        -1.794655442237854,
                        0.22748638689517975,
                        2.360928773880005
                    )

                local config2 = {}

                config2["4"] =
                    v5.Parent:FindFirstChild("Humanoid")

                config2["2"] =
                    v5.Parent:FindFirstChild("Humanoid")

                config[4] = config2

                local ReplicatedStorage =
                    game:GetService("ReplicatedStorage")

                ReplicatedStorage.Remotes.Weapon.Shoot:FireServer()

                local config3 = {}

                config3[1] =
                    workspace:GetServerTimeNow()

                config3[2] =
                    game.Players.LocalPlayer.Character:
                    FindFirstChildOfClass("Tool")

                local ReplicatedStorage2 =
                    game:GetService("ReplicatedStorage")

                ReplicatedStorage2.Remotes.Weapon.Reload:FireServer()
            end

            return v5
        end
    end
end

--==================================================
-- UNLOCK CAM LOGIC
--==================================================

local function func_2b6fb775()

    local _upv0 = game.Players.LocalPlayer
    local _upv1 = workspace.CurrentCamera

    _upv0.CameraMode = Enum.CameraMode.Classic
    _upv0.CameraMinZoomDistance = 0
    _upv0.CameraMaxZoomDistance = 150
    _upv1.CameraSubject = _upv0.Character.Humanoid

    return
end

return
