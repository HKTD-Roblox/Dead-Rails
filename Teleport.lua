local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("ToraScript") then
    CoreGui.ToraScript:Destroy()
end

local loadedFn = loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew", true))()
local Window = loadedFn:CreateWindow("Teleport Dead Rails")

local function getCharacter()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    local hum = char:WaitForChild("Humanoid", 5)
    return char, hrp, hum
end

local function tweenTo(targetCFrame, duration)
    local _, hrp = getCharacter()
    if hrp then
        local tweenInfo = TweenInfo.new(duration or 2, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

Window:AddButton({
    text = "Teleport to End",
    flag = "END",
    callback = function()
        local _, hrp = getCharacter()
        if hrp then
            hrp.CFrame = CFrame.new(-428.7, 28.0, -49040.9)
        end
    end,
})

Window:AddButton({
    text = "Teleport to Castle",
    flag = "Castle",
    callback = function()
        local _, hrp = getCharacter()
        if hrp then
            hrp.CFrame = CFrame.new(248, 24, -9059)
        end
    end,
})

Window:AddButton({
    text = "Teleport to TeslaLab",
    flag = "TeslaLab",
    callback = function()
        local _, hrp = getCharacter()
        if hrp then
            if workspace:FindFirstChild("TeslaLab") and workspace.TeslaLab:FindFirstChild("Generator") then
                hrp.CFrame = workspace.TeslaLab.Generator.Generator.CFrame * CFrame.new(0, 5, 0)
            else
                hrp.CFrame = CFrame.new(56, 3, 29760)
            end
        end
    end,
})

Window:AddButton({
    text = "Teleport to Sterling",
    flag = "Sterling",
    callback = function()
        local sterling = workspace:FindFirstChild("Sterling")
        if sterling and sterling:FindFirstChild("Town") and sterling.Town:FindFirstChild("Road") then
            tweenTo(sterling.Town.Road.CFrame * CFrame.new(0, 5, 0), 3)
        else
            tweenTo(CFrame.new(-424, 30, -49041), 5)
        end
    end,
})

Window:AddButton({
    text = "Teleport to Fort",
    flag = "Fort",
    callback = function()
        local _, hrp = getCharacter()
        local runtimeItems = workspace:FindFirstChild("RuntimeItems")
        if runtimeItems and runtimeItems:FindFirstChild("Cannon") then
            local cannon = runtimeItems.Cannon
            if cannon:FindFirstChild("VehicleSeat") then
                hrp.CFrame = cannon.VehicleSeat.CFrame * CFrame.new(0, 3, 0)
                return
            end
        end
        tweenTo(CFrame.new(56, 3, 29760), 3)
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
