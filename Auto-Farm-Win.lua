local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("ToraScript") then
    local CoreGui2 = game:GetService("CoreGui")
    CoreGui2.ToraScript:Destroy()
end

local loadedFn = loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew", true))()
local v = loadedFn:CreateWindow("Dead Rails")
v:AddButton({
    text = "TP to End",
    flag = "END",
    callback = function()
        local localPlayer = game.Players.LocalPlayer.Character

        while true do

            if not (localPlayer:WaitForChild("Humanoid").Sit) then
                localPlayer:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-428.745911, 28.0728378, -49040.9062)

                task.wait()
            end
        end
    end,
})
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
                    for v, v2 in pairs(workspace.RuntimeItems:GetChildren()) do

                        if v2:GetAttribute("ActivateText") ~= "Collect Bond" and v2:GetAttribute("ActivateText") == "Collect" then
                            local config = {}
                            config[1] = v2
                            local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
v:AddButton({
    text = "TP to Castle",
    flag = "button",
    callback = function()
        while true do

            if tick() - tick() < 1 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(248, 24, -9059)

                task.wait()
            end
        end

        while true do

            if tick() - tick() < 3 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace.RuntimeItems.MaximGun.VehicleSeat.Position)
                workspace.RuntimeItems.MaximGun.VehicleSeat.Disabled = false

                task.wait()
            end
        end
    end,
})
v:AddButton({
    text = "TP to TeslaLab",
    flag = "button",
    callback = function(...)
        local v, v2 = pcall(function(...)
            while true do

                if tick() - tick() < 1 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace.TeslaLab.Generator.Generator.Position)

                    task.wait()
                end
            end

            for v, v2 in pairs(workspace:GetDescendants()) do

                if v2:IsA("Seat") then
                    local v3 = v2.Position - workspace.TeslaLab.Generator.Generator.Position.Magnitude

                    if v3 < math.huge then
                        local v4 = v2
                    end
                end
            end

            if v4 then

                while true do

                    if tick() - tick() < 3 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new()
                        workspace.RuntimeItems.Chair.Seat.Disabled = false

                        task.wait()
                    end
                end

                return

            end
        end)

        if not (v) then
            local Players = game:GetService("Players")
            local TweenService = game:GetService("TweenService")
            local localPlayer = Players.LocalPlayer

            if not (localPlayer.Character) then
                local v3 = localPlayer.CharacterAdded:Wait()
            end

            local v4 = v3:WaitForChild("HumanoidRootPart")
            local v5 = TweenService:Create(v4, TweenInfo.new(50, Enum.EasingStyle.Linear), {
                CFrame = CFrame.new(-424, 30, -49041),
            })
            v4.CFrame = CFrame.new(56, 3, 29760)
            v5:Play()
            local _upv0 = true
            local _upv3 = v3:WaitForChild("Humanoid")

            task.spawn(function(...)
                while true do

                    if _upv0 then

                        if workspace:FindFirstChild("RuntimeItems") then
                            local v = workspace.RuntimeItems:FindFirstChild("BrainJar", true)
                        end

                        for v2, v3 in pairs(workspace.RuntimeItems:GetDescendants()) do

                            if v3.Name == "Jar" then
                            else
                            end
                        end

                        if true and v and v:FindFirstChild("Brain") then

                            if v.Brain:FindFirstChild("Jar") then
                                v5:Cancel()
                                _upv0 = false

                                for v4, v5 in pairs(workspace.RuntimeItems:GetDescendants()) do

                                    if v5:IsA("Seat") then
                                        local v6 = v5.Position - v.Brain.Jar.Position.Magnitude

                                        if v6 < math.huge then
                                            local v7 = v5
                                        end
                                    end
                                end

                                if v7 then

                                    while true do

                                        if tick() - tick() < 3 then
                                            v4.CFrame = CFrame.new(v7.Position)
                                            v7.Disabled = false

                                            task.wait()
                                        end
                                    end

                                    task.wait()

                                    if _upv3.Sit ~= true then

                                        task.wait(0.2)
                                    end
                                end
                            end

                            return

                        end
                    end
                end
            end)
        end
    end,
})
v:AddButton({
    text = "TP to Sterling",
    flag = "button",
    callback = function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local localPlayer = Players.LocalPlayer

        if not (localPlayer.Character) then
            local v = localPlayer.CharacterAdded:Wait()
        end

        local v2 = v:WaitForChild("HumanoidRootPart")
        local v3 = TweenService:Create(v2, TweenInfo.new(40, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(-424, 30, -49041),
        })
        v2.CFrame = CFrame.new(56, 3, 29760)
        v3:Play()
        local _upv0 = true
        local _upv3 = v:WaitForChild("Humanoid")

        task.spawn(function(...)
            while true do

                if _upv0 then
                    local v = workspace:FindFirstChild("Sterling")

                    if v then
                        local v2 = v:FindFirstChild("Town")

                        if v2 then
                            local v3 = v2:FindFirstChild("Road")

                            if v3 then
                                v3:Cancel()
                                _upv0 = false
                                local v4 = tick()
                                local v5 = v3.CFrame * CFrame.new(0, 5, 0)

                                while true do

                                    if tick() - v4 < 2 then
                                        v2.CFrame = v5

                                        task.wait()
                                    end
                                end

                                wait(0.2)
                                workspace.RuntimeItems.Chair.Seat.CFrame = v2.CFrame * CFrame.new(0, 5, 0)

                                while true do

                                    if tick() - v4 < 5 then
                                        v2.CFrame = v5
                                        workspace.RuntimeItems.Chair.Seat.Disabled = false
                                        workspace.RuntimeItems.Chair.Seat.CFrame = v2.CFrame * CFrame.new(0, -1, 0)

                                        task.wait()
                                    end
                                end

                                task.wait()

                                if _upv3.Sit ~= true then

                                    task.wait(0.2)
                                end
                            end

                            return

                        end
                    end
                end
            end
        end)
    end,
})
v:AddButton({
    text = "TP to Fort",
    flag = "button",
    callback = function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local localPlayer = Players.LocalPlayer

        if not (localPlayer.Character) then
            local v = localPlayer.CharacterAdded:Wait()
        end

        local v2 = v:WaitForChild("HumanoidRootPart")
        local v3 = TweenService:Create(v2, TweenInfo.new(50, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(-424, 30, -49041),
        })
        v2.CFrame = CFrame.new(56, 3, 29760)
        v3:Play()
        local _upv0 = true
        local _upv3 = v:WaitForChild("Humanoid")

        task.spawn(function(...)
            while true do

                if _upv0 then

                    if workspace:FindFirstChild("RuntimeItems") then
                        local v = workspace.RuntimeItems:FindFirstChild("Cannon")
                    end

                    if v then

                        if v:FindFirstChild("VehicleSeat") then
                            v3:Cancel()
                            _upv0 = false
                            local v2 = v.VehicleSeat

                            while true do

                                if tick() - tick() < 3 then
                                    v2.CFrame = CFrame.new(v2.Position)
                                    v2.Disabled = false

                                    task.wait()
                                end
                            end

                            repeat

                                task.wait()
                            until _upv3.Sit == true
                        else

                            task.wait(0.2)
                        end
                    end

                    return

                end
            end
        end)
    end,
})
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
local v2 = loadedFn:CreateWindow("Main")
v2:AddButton({
    text = "TP to Train",
    flag = "Train",
    callback = function(...)
        local localPlayer = game.Players.LocalPlayer.Character

        for v, v2 in pairs(workspace:GetChildren()) do

            if v2:IsA("Model") and v2:GetAttribute("serverEntityId") then

                for v3, v4 in pairs(v2:GetDescendants()) do

                    if v4.Name == "VehicleSeat" then

                        while true do

                            if not (localPlayer:WaitForChild("Humanoid").Sit) then
                                localPlayer:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(v4.Position)

                                task.wait()
                            end
                        end
                    end
                end
            end
        end
    end,
})
local config11 = {}
local RunService = game:GetService("RunService")
v2:AddToggle({
    text = "Items ESP",
    flag = "toggle",
    state = false,
    callback = function(p0)
        func_99781bc0(p0)

        if p0 then

            task.spawn(function(...)
                while true do

                    for v, v2 in pairs(workspace.RuntimeItems:GetChildren()) do

                        if v2:IsA("BasePart") then
                            func_3b536a8e(v2, v2.Name)
                        end
                    end
                end
            end)
        end
    end,
})
local config13 = {}
local RunService2 = game:GetService("RunService")
v2:AddToggle({
    text = "Mobs ESP",
    flag = "toggle",
    state = false,
    callback = function(p0)
        func_c2e7cc17(p0)

        if p0 then

            task.spawn(function()
                while true do

                    func_260ab822()
                end
            end)
        end
    end,
})
local RunService3 = game:GetService("RunService")
local config15 = {}
local v3 = nil
updateUnicorns = function(...)
    for v, v2 in pairs(config15) do

        if v2.circle then
            v2.circle:Remove()
        end

        if v2.text then
            v2.text:Remove()
        end
    end

    table.clear(config15)

    for v3, v4 in pairs(workspace:GetDescendants()) do

        if v4.Name == "Unicorn" and v4:IsA("Model") and v4:FindFirstChild("HumanoidRootPart") then
            local v5 = Drawing.new("Circle")
            v5.Color = Color3.fromRGB(255, 0, 0)
            v5.Radius = 10
            v5.Thickness = 2
            v5.Filled = false
            v5.Visible = true
            local v6 = Drawing.new("Text")
            v6.Text = "Unicorn"
            v6.Size = 16
            v6.Color = Color3.fromRGB(255, 255, 255)
            v6.Center = true
            v6.Outline = true
            v6.OutlineColor = Color3.fromRGB(0, 0, 0)
            v6.Font = 2
            v6.Visible = true
            config15[#config15 + 1] = {
                model = v4,
                circle = v5,
                text = v6,
            }
        end
    end
end
local _upv3 = workspace.CurrentCamera
startESP = function(...)
    updateUnicorns()
    v3 = RunService3.RenderStepped:Connect(function(...)
        for v, v2 in ipairs(config15) do
            local v3 = v2.model:FindFirstChild("HumanoidRootPart")

            if v3 and v2.circle and v2.text then
                local v4, v5 = _upv3:WorldToViewportPoint(v3.Position)

                if v5 then
                    local v6 = Vector2.new(v4.X, v4.Y)
                    v2.circle.Position = v6
                    v2.circle.Visible = true
                    v2.text.Position = v6 + Vector2.new(0, 15)
                    v2.text.Visible = true
                end

                v2.circle.Visible = false
                v2.text.Visible = false
            end

            if v2.circle then
                v2.circle.Visible = false
            end

            if v2.text then
                v2.text.Visible = false
            end
        end
    end)

    task.spawn(function()
        while true do

            if _G.UnicornESP then
                updateUnicorns()

                task.wait(2)
            end
        end
    end)
end
stopESP = function(...)
    if v3 then
        v3:Disconnect()
    end

    for v, v2 in pairs(config15) do

        if v2.circle then
            v2.circle:Remove()
        end

        if v2.text then
            v2.text:Remove()
        end
    end

    table.clear(config15)
end
v2:AddToggle({
    text = "Unicorn ESP",
    flag = "UnicornESP",
    state = false,
    callback = function(p0)
        _G.UnicornESP = p0
        print("Unicorn ESP:", p0)

        if p0 then
            startESP()
        else
            stopESP()
        end
    end,
})
v2:AddButton({
    text = "UnlockCam",
    flag = "button",
    callback = function()
        local _upv0 = game.Players.LocalPlayer
        local _upv1 = workspace.CurrentCamera
        func_2b6fb775()
    end,
})
v2:AddButton({
    text = "FullBright",
    flag = "button",
    callback = function()
        if not (_G.FullBrightExecuted) then
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
                        _G.NormalLightingSettings.Brightness = Lighting3.Brightness

                        if not (_G.FullBrightEnabled) then

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
                        _G.NormalLightingSettings.ClockTime = Lighting3.ClockTime

                        if not (_G.FullBrightEnabled) then

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
                        _G.NormalLightingSettings.FogEnd = Lighting3.FogEnd

                        if not (_G.FullBrightEnabled) then

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

                    if Lighting2.GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
                        local Lighting3 = game:GetService("Lighting")
                        _G.NormalLightingSettings.GlobalShadows = Lighting3.GlobalShadows

                        if not (_G.FullBrightEnabled) then

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

                    if Lighting2.Ambient ~= _G.NormalLightingSettings.Ambient then
                        local Lighting3 = game:GetService("Lighting")
                        _G.NormalLightingSettings.Ambient = Lighting3.Ambient

                        if not (_G.FullBrightEnabled) then

                            repeat
                                wait()
                            until _G.FullBrightEnabled
                        end

                        local Lighting4 = game:GetService("Lighting")
                        Lighting4.Ambient = Color3.fromRGB(178, 178, 178)
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

                    if not (_G.FullBrightEnabled) then
                        local Lighting = game:GetService("Lighting")
                        Lighting.Brightness = _G.NormalLightingSettings.Brightness
                        local Lighting2 = game:GetService("Lighting")
                        Lighting2.ClockTime = _G.NormalLightingSettings.ClockTime
                        local Lighting3 = game:GetService("Lighting")
                        Lighting3.FogEnd = _G.NormalLightingSettings.FogEnd
                        local Lighting4 = game:GetService("Lighting")
                        Lighting4.GlobalShadows = _G.NormalLightingSettings.GlobalShadows
                        local Lighting5 = game:GetService("Lighting")
                        Lighting5.Ambient = _G.NormalLightingSettings.Ambient
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
                        Lighting10.Ambient = Color3.fromRGB(178, 178, 178)
                    end

                    _upv0 = not _upv0
                end
            end)
        end

        _G.FullBrightExecuted = false
        _G.FullBrightEnabled = not _G.FullBrightEnabled
    end,
})
v2:AddButton({
    text = "Inf Jump",
    flag = "button",
    callback = function()
        local UserInputService = game:GetService("UserInputService")
        UserInputService.JumpRequest:Connect(function()
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end)
    end,
})
v2:AddToggle({
    text = "Walk Speed",
    flag = "toggle",
    state = false,
    callback = function(p0)
        _G.Speed = p0
        print("Speed: ", p0)
        local localPlayer = game.Players.LocalPlayer

        if localPlayer.Character then
            local v = localPlayer.Character:FindFirstChild("Humanoid")
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
local v4 = nil
local v5 = nil
noclip = function(...)
    v5 = false
    local RunService = game:GetService("RunService")
    v4 = RunService.Stepped:Connect(function(...)
        if not (v5) and game.Players.LocalPlayer.Character then

            for v, v2 in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do

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
v2:AddToggle({
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
loadedFn:Init()
local CoreGui3 = game:GetService("CoreGui")
local _upv0 = 600
local _upv1 = CoreGui3.ToraScript.ImageButton.Frame.Frame.TextBox
func_cc7c4015()
local _upv0 = nil

local function func_cc7c4015()

    while true do

        if 0 < _upv0 then
            _upv1.Text = string.format("%02d:%02d", math.floor(_upv0 / 60), _upv0 % 60)
            wait(1)
            _upv0 = _upv0 - 1
        end
    end

    _upv1.Text = "00:00"

    return

end

local function func_aa65d143(p0, p1)

    if not (checkcaller()) then
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

    -- [35] TailCall: return R2(R3, R4)

    return _upv0

end

local function func_99781bc0(p0)
    _G.Items = p0

    if not (p0) then

        for v, v2 in pairs(config11) do

            if v2 then
                v2:Destroy()
            end
        end

        local config = {}
        config11 = config
    else
        for v3, v4 in pairs(workspace.RuntimeItems:GetChildren()) do

            if v4:IsA("BasePart") then
                func_3b536a8e(v4, v4.Name)
            end
        end
    end

    return

end

local function func_c2e7cc17(p0)
    _G.Mobs = p0

    if not (p0) then

        for v, v2 in pairs(config13) do

            if v2 then
                v2:Destroy()
            end
        end

        local config = {}
        config13 = config
    else
        func_260ab822()
    end

    return

end

local function func_3b536a8e(p0, p1)

    if _G.Items then

        if config11[p0] then

            return

        end

        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESP"
        billboardGui.Adornee = p0
        billboardGui.Size = UDim2.new(0, 100, 0, 30)
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
        billboardGui.AlwaysOnTop = true
        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboardGui
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = p1
        textLabel.TextColor3 = Color3.fromRGB(204, 255, 204)
        textLabel.TextStrokeTransparency = 0
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextSize = 16
        local CoreGui = game:GetService("CoreGui")
        billboardGui.Parent = CoreGui
        config11[p0] = billboardGui

        return

    end
end

local function func_b1b7f2ce(...)

    for v, v2 in ipairs(workspace:GetDescendants()) do

        if v2.Name == "HumanoidRootPart" then

            if not (v2.Parent:GetAttribute("EntityName")) and v2.Name == "HumanoidRootPart" and v2.Parent:GetAttribute("Bounty") then
                local v3 = v2.Parent:FindFirstChild("Humanoid")

                if v3 and 0 < v3.Health then
                    local v4 = _upv0:DistanceFromCharacter(v2.Position)

                    if v4 < math.huge then
                        local v5 = v2
                    end
                end
            end

            if v5 then
                local config = {}
                config[1] = workspace:GetServerTimeNow()
                config[2] = _upv0.Character:FindFirstChildOfClass("Tool")
                config[3] = v5.CFrame * CFrame.Angles(-1.794655442237854, 0.22748638689517975, 2.360928773880005)
                local config2 = {}
                config2["4"] = v5.Parent:FindFirstChild("Humanoid")
                config2["2"] = v5.Parent:FindFirstChild("Humanoid")
                config[4] = config2
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                ReplicatedStorage.Remotes.Weapon.Shoot:FireServer()
                local config3 = {}
                config3[1] = workspace:GetServerTimeNow()
                config3[2] = _upv0.Character:FindFirstChildOfClass("Tool")
                local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
                ReplicatedStorage2.Remotes.Weapon.Reload:FireServer()
            end

            return v5

        end
    end
end

local function func_260ab822(...)

    for v, v2 in ipairs(workspace:GetDescendants()) do

        if v2:IsA("BasePart") and v2.Name == "HumanoidRootPart" then
            local v3 = v2.Parent

            if not (v3:GetAttribute("EntityName")) and v3:GetAttribute("Bounty") and not (config13[v3]) then
                local highlight = Instance.new("Highlight")
                highlight.Parent = v3
                highlight.FillTransparency = 0.3
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                config13[v3] = highlight
            end

            return

        end
    end
end

local function func_2b6fb775()
    _upv0.CameraMode = Enum.CameraMode.Classic
    _upv0.CameraMinZoomDistance = 0
    _upv0.CameraMaxZoomDistance = 150
    _upv1.CameraSubject = _upv0.Character.Humanoid

    return

end

return

return

end

return

end

return

end
