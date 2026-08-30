local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local success, info = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)

if not success or not info or info.Name ~= "Dead Rails" then
    Player:Kick("This Script can only be used in Dead Rails...")
    return
end

local PlayerGui = Player:WaitForChild("PlayerGui")

local GUI = Instance.new("ScreenGui")
GUI.Name = "AutoFarmBonds"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 390, 0, 235)
Main.Position = UDim2.new(0.5, -195, 0.5, -117)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
Main.BorderSizePixel = 0
Main.Parent = GUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(255, 115, 25)
Stroke.Parent = Main

local Glow = Instance.new("UIStroke")
Glow.Thickness = 7
Glow.Transparency = 0.78
Glow.Color = Color3.fromRGB(255, 100, 20)
Glow.Parent = Main

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 10)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 70, 10))
})
Gradient.Parent = Stroke

task.spawn(function()
    while Main.Parent do
        for i = -1, 1, 0.025 do
            Gradient.Offset = Vector2.new(i, 0)
            task.wait(0.02)
        end
        for i = 1, -1, -0.025 do
            Gradient.Offset = Vector2.new(i, 0)
            task.wait(0.02)
        end
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 34)
Title.Position = UDim2.new(0, 10, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "Auto Farm Bonds - Dead Rails"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.TextSize = 19
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = Main

local function CreateInfoBox(position)
    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(0, 170, 0, 42)
    Box.Position = position
    Box.BackgroundColor3 = Color3.fromRGB(32, 32, 36)
    Box.BorderSizePixel = 0
    Box.Parent = Main

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Box

    return Box
end

local TimeBox = CreateInfoBox(UDim2.new(0, 20, 0, 51))
local BondBox = CreateInfoBox(UDim2.new(1, -190, 0, 51))

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(1, 0, 1, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "Time: 00:00:00"
TimeLabel.TextColor3 = Color3.fromRGB(75, 220, 105)
TimeLabel.TextSize = 15
TimeLabel.Font = Enum.Font.GothamBold
TimeLabel.Parent = TimeBox

local BondLabel = Instance.new("TextLabel")
BondLabel.Size = UDim2.new(1, 0, 1, 0)
BondLabel.BackgroundTransparency = 1
BondLabel.Text = "Bonds: 00"
BondLabel.TextColor3 = Color3.fromRGB(255, 135, 35)
BondLabel.TextSize = 15
BondLabel.Font = Enum.Font.GothamBold
BondLabel.Parent = BondBox

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -30, 0, 25)
Status.Position = UDim2.new(0, 15, 0, 99)
Status.BackgroundTransparency = 1
Status.Text = "Status: Joining the Game..."
Status.TextColor3 = Color3.fromRGB(190, 165, 45)
Status.TextSize = 13
Status.Font = Enum.Font.GothamMedium
Status.TextXAlignment = Enum.TextXAlignment.Center
Status.Parent = Main

local function CreateButton(parent, text, position, size)
    local Button = Instance.new("TextButton")
    Button.Size = size
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(35, 155, 75)
    Button.BorderSizePixel = 0
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = true
    Button.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    return Button
end

local DiscordButton = CreateButton(
    Main,
    "Copy Discord",
    UDim2.new(0, 62, 0, 135),
    UDim2.new(0, 125, 0, 32)
)

local CreditButton = CreateButton(
    Main,
    "Credit",
    UDim2.new(1, -187, 0, 135),
    UDim2.new(0, 125, 0, 32)
)

local startTime = os.clock()

task.spawn(function()
    while GUI.Parent do
        local elapsed = math.floor(os.clock() - startTime)
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60

        TimeLabel.Text = string.format(
            "Time: %02d:%02d:%02d",
            hours,
            minutes,
            seconds
        )

        task.wait(1)
    end
end)

local function SetLobbyStatus()
    Status.Text = "Status: Joining the Game..."
end

local function SetFarmingStatus()
    Status.Text = "Status: Getting All Bonds..."
end

local function SetFinishedStatus()
    Status.Text = "Status: All Bonds Collected! Teleporting to the Lobby..."
end

local function CopyDiscord(Button)
    if setclipboard then
        setclipboard("https://discord.gg/2ACZAkcmDP")
    end

    Button.Text = "Link Copied!"

    task.delay(2, function()
        if Button and Button.Parent then
            Button.Text = "Copy Discord"
        end
    end)
end

DiscordButton.MouseButton1Click:Connect(function()
    CopyDiscord(DiscordButton)
end)

local Credit = Instance.new("Frame")
Credit.Size = UDim2.new(0.88, 0, 0.78, 0)
Credit.Position = UDim2.new(0.06, 0, 0.11, 0)
Credit.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
Credit.BorderSizePixel = 0
Credit.Visible = false
Credit.ZIndex = 10
Credit.Parent = GUI

local CreditCorner = Instance.new("UICorner")
CreditCorner.CornerRadius = UDim.new(0, 15)
CreditCorner.Parent = Credit

local CreditStroke = Instance.new("UIStroke")
CreditStroke.Thickness = 2
CreditStroke.Color = Color3.fromRGB(55, 210, 100)
CreditStroke.Parent = Credit

local CreditGlow = Instance.new("UIStroke")
CreditGlow.Thickness = 7
CreditGlow.Transparency = 0.8
CreditGlow.Color = Color3.fromRGB(40, 220, 90)
CreditGlow.Parent = Credit

local CreditGradient = Instance.new("UIGradient")
CreditGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 210, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 255, 165)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 210, 80))
})
CreditGradient.Parent = CreditStroke

task.spawn(function()
    while Credit.Parent do
        for i = -1, 1, 0.025 do
            CreditGradient.Offset = Vector2.new(i, 0)
            task.wait(0.025)
        end
    end
end)

local CreditTitle = Instance.new("TextLabel")
CreditTitle.Size = UDim2.new(1, -20, 0, 35)
CreditTitle.Position = UDim2.new(0, 10, 0, 8)
CreditTitle.BackgroundTransparency = 1
CreditTitle.Text = "SCRIPT CREATED BY HKTD ROBLOX"
CreditTitle.TextColor3 = Color3.fromRGB(245, 245, 245)
CreditTitle.TextSize = 17
CreditTitle.Font = Enum.Font.GothamBold
CreditTitle.ZIndex = 11
CreditTitle.Parent = Credit

local VN = Instance.new("TextLabel")
VN.Size = UDim2.new(1, -30, 0, 105)
VN.Position = UDim2.new(0, 15, 0, 47)
VN.BackgroundTransparency = 1
VN.Text = "🇻🇳 Tiếng Việt:\n\nXin Chào! Tôi là Hoàng Kim Tiến Đạt (HKTD Roblox).\nCảm ơn bạn đã sử dụng Script của mình nếu thấy lỗi\nhãy vào Discord của mình để báo cáo lỗi nhé!"
VN.TextColor3 = Color3.fromRGB(245, 245, 245)
VN.TextSize = 12
VN.Font = Enum.Font.Gotham
VN.TextWrapped = true
VN.TextYAlignment = Enum.TextYAlignment.Top
VN.ZIndex = 11
VN.Parent = Credit

local EN = Instance.new("TextLabel")
EN.Size = UDim2.new(1, -30, 0, 105)
EN.Position = UDim2.new(0, 15, 0, 140)
EN.BackgroundTransparency = 1
EN.Text = "🇺🇸 English:\n\nHello! I am Hoàng Kim Tiến Đạt (HKTD Roblox).\nThank you for using my Script, if you encounter any errors,\nplease join my Discord to report them!"
EN.TextColor3 = Color3.fromRGB(245, 245, 245)
EN.TextSize = 12
EN.Font = Enum.Font.Gotham
EN.TextWrapped = true
EN.TextYAlignment = Enum.TextYAlignment.Top
EN.ZIndex = 11
EN.Parent = Credit

local CreditDiscord = CreateButton(
    Credit,
    "Copy Discord",
    UDim2.new(0, 30, 1, -43),
    UDim2.new(0, 120, 0, 30)
)
CreditDiscord.ZIndex = 11

local OK = CreateButton(
    Credit,
    "OK",
    UDim2.new(1, -130, 1, -43),
    UDim2.new(0, 100, 0, 30)
)
OK.ZIndex = 11

CreditButton.MouseButton1Click:Connect(function()
    Credit.Visible = true
end)

OK.MouseButton1Click:Connect(function()
    Credit.Visible = false
end)

CreditDiscord.MouseButton1Click:Connect(function()
    CopyDiscord(CreditDiscord)
end)

local dragging = false
local dragStart
local startPosition
local dragConnection

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        if dragConnection then
            dragConnection:Disconnect()
        end

        dragConnection = UserInputService.InputChanged:Connect(function(move)
            if not dragging then
                return
            end

            if move.UserInputType == Enum.UserInputType.MouseMovement
            or move.UserInputType == Enum.UserInputType.Touch then

                local delta = move.Position - dragStart

                Main.Position = UDim2.new(
                    startPosition.X.Scale,
                    startPosition.X.Offset + delta.X,
                    startPosition.Y.Scale,
                    startPosition.Y.Offset + delta.Y
                )
            end
        end)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false

        if dragConnection then
            dragConnection:Disconnect()
            dragConnection = nil
        end
    end
end)

SetLobbyStatus()
