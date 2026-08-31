local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("ToraScript") then
    CoreGui.ToraScript:Destroy()
end

-- 1. HÀM TRÍCH XUẤT HUMANOIDROOTPART
local function getHRP()
    local c = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return c:FindFirstChild("HumanoidRootPart") or c:WaitForChild("HumanoidRootPart", 5)
end

-- 2. BLACKLIST CHẶN CÁC OBJECT TRÊN TÀU VÀ MAP
local BLACKLIST_TERMS = {
    "train", "boiler", "engine", "door", "seat", "chair", "cart",
    "chest", "safe", "crate", "barrel", "structure", "wall", "floor", 
    "terrain", "track", "wheel", "lamp", "lantern", "window", "table"
}

local function isBlacklisted(str)
    str = string.lower(tostring(str or ""))
    for _, k in ipairs(BLACKLIST_TERMS) do
        if str:find(k, 1, true) then return true end
    end
    return false
end

local function matchesKeywords(str, keywords)
    str = string.lower(tostring(str or ""))
    if isBlacklisted(str) then return false end
    for _, k in ipairs(keywords) do
        if str:find(k, 1, true) then return true end
    end
    return false
end

-- 3. HÀM KIỂM TRA ITEM HỢP LỆ THEO TỪ KHÓA ĐƯỢC CHỈ ĐỊNH
local function isValidTargetItem(obj, targetKeywords)
    if not obj or not obj.Parent then return false end
    if obj:IsDescendantOf(LocalPlayer.Character) then return false end

    if isBlacklisted(obj.Name) or (obj.Parent and isBlacklisted(obj.Parent.Name)) then
        return false
    end

    -- Lớp 1: CollectionService Tags
    local tags = CollectionService:GetTags(obj)
    for _, tag in ipairs(tags) do
        if matchesKeywords(tag, targetKeywords) then return true end
    end

    -- Lớp 2: Server Attributes
    local ok, attrs = pcall(function() return obj:GetAttributes() end)
    if ok and attrs then
        for k, val in pairs(attrs) do
            if matchesKeywords(k, targetKeywords) or matchesKeywords(val, targetKeywords) then
                return true
            end
        end
    end

    -- Lớp 3: ProximityPrompt
    local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt then
        local pText = tostring(prompt.ObjectText) .. " " .. tostring(prompt.ActionText)
        if matchesKeywords(pText, targetKeywords) then
            return true
        end
    end

    -- Lớp 4: Tên Object
    if matchesKeywords(obj.Name, targetKeywords) then
        return true
    end

    return false
end

local function getTargetPart(obj)
    if obj:IsA("BasePart") then return obj end
    if obj:IsA("Model") then
        return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
    end
    if obj:IsA("Tool") then
        return obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart", true)
    end
    return obj:FindFirstChildWhichIsA("BasePart", true)
end

-- 4. CORE ENGINE BRING THEO DANH SÁCH TỪ KHÓA
local function bringItemsByKeywords(keywords)
    local hrp = getHRP()
    if not hrp then return end

    local targetContainers = {
        workspace:FindFirstChild("RuntimeItems"),
        workspace:FindFirstChild("Items"),
        workspace:FindFirstChild("Pickups"),
        workspace:FindFirstChild("Loot"),
        workspace:FindFirstChild("Drops"),
        workspace
    }

    local itemsToBring = {}
    local processedMap = {}

    for _, container in ipairs(targetContainers) do
        if container then
            for _, obj in ipairs(container:GetChildren()) do
                if isValidTargetItem(obj, keywords) then
                    local rootObj = obj
                    if obj:IsA("BasePart") and obj.Parent and obj.Parent:IsA("Model") and isValidTargetItem(obj.Parent, keywords) then
                        rootObj = obj.Parent
                    end

                    if not processedMap[rootObj] then
                        local mainPart = getTargetPart(rootObj)
                        if mainPart and not mainPart:IsDescendantOf(LocalPlayer.Character) then
                            processedMap[rootObj] = true
                            table.insert(itemsToBring, {root = rootObj, part = mainPart})
                        end
                    end
                end
            end
        end
    end

    -- Dịch chuyển item tới vị trí trước mặt (3 studs)
    local spawnCFrame = hrp.CFrame * CFrame.new(0, 0, -3)

    for _, itemData in ipairs(itemsToBring) do
        local root = itemData.root
        local part = itemData.part

        if root and root.Parent and part and part.Parent then
            pcall(function()
                if root:IsA("Model") then
                    root:PivotTo(spawnCFrame)
                elseif root:IsA("Tool") and root:FindFirstChild("Handle") then
                    root.Handle.CFrame = spawnCFrame
                else
                    part.CFrame = spawnCFrame
                end

                for _, p in ipairs(root:IsA("Model") and root:GetDescendants() or {part}) do
                    if p:IsA("BasePart") then
                        p.AssemblyLinearVelocity = Vector3.zero
                        p.AssemblyAngularVelocity = Vector3.zero
                        p.CanCollide = false
                    end
                end
            end)
        end
    end
end

-- 5. KHỞI TẠO TORA LIBRARY UI
local loadedFn = loadstring(game:HttpGet("https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew", true))()
local Window = loadedFn:CreateWindow("Dead Rails - Bring Items")

Window:AddButton({
    text = "Bring Bonds",
    flag = "Bonds",
    callback = function()
        bringItemsByKeywords({"bond", "bonds"})
    end,
})

Window:AddButton({
    text = "Bring Healing",
    flag = "Healing",
    callback = function()
        bringItemsByKeywords({"bandage", "snake oil", "snakeoil"})
    end,
})

Window:AddButton({
    text = "Bring Gun",
    flag = "Gun",
    callback = function()
        bringItemsByKeywords({"pistol", "revolver", "rifle", "shotgun", "mauser", "maxim"})
    end,
})

Window:AddButton({
    text = "Bring Weapons",
    flag = "Weapons",
    callback = function()
        bringItemsByKeywords({
            "pistol", "revolver", "rifle", "shotgun", "mauser", "maxim",
            "shovel", "axe", "saber", "knife", "dynamite", "molotov"
        })
    end,
})

Window:AddButton({
    text = "Bring Ammo",
    flag = "Ammo",
    callback = function()
        bringItemsByKeywords({"ammo", "bullet", "shell", "cartridge"})
    end,
})

Window:AddButton({
    text = "Bring Armor",
    flag = "Armor",
    callback = function()
        bringItemsByKeywords({"helmet", "chestplate"})
    end,
})

Window:AddButton({
    text = "Bring Coal",
    flag = "Coal",
    callback = function()
        bringItemsByKeywords({"coal"})
    end,
})

Window:AddLabel({
    text = "Make by HKTD Roblox",
})
