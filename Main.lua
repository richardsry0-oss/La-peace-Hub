
--[[
    LA PEACE HUB
    By Kai
    Version: 0.1.0
    Phase 1: Main Interface
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- CONFIGURATION

local Config = {
    Name = "LA PEACE HUB",
    Version = "0.1.0",

    Icon = "rbxassetid://108294449126537",
    Background = "rbxassetid://17582945598",

    BackgroundColor = Color3.fromRGB(17, 19, 25),
    PanelColor = Color3.fromRGB(25, 28, 36),
    Accent = Color3.fromRGB(65, 135, 220),
    TextColor = Color3.fromRGB(240, 242, 248),
    Muted = Color3.fromRGB(155, 163, 177)
}

-- CLEANUP

local Old = PlayerGui:FindFirstChild("LaPeaceHub")

if Old then
    Old:Destroy()
end

-- GUI ROOT

local Screen = Instance.new("ScreenGui")
Screen.Name = "LaPeaceHub"
Screen.ResetOnSpawn = false
Screen.IgnoreGuiInset = true
Screen.DisplayOrder = 999
Screen.Parent = PlayerGui

local function Create(class, properties, parent)
    local obj = Instance.new(class)

    for property, value in pairs(properties) do
        obj[property] = value
    end

    obj.Parent = parent
    return obj
end

local function Corner(parent, radius)
    Create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, parent)
end

local function Stroke(parent, color, transparency)
    Create("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = 1
    }, parent)
end

local function Label(parent, text, size, position, fontSize)
    return Create("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Config.TextColor,
        TextSize = fontSize or 14,
        Font = Enum.Font.Gotham,
        Size = size,
        Position = position,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
end

local function Button(parent, text, size, position)
    local button = Create("TextButton", {
        BackgroundColor3 = Config.PanelColor,
        Text = text,
        TextColor3 = Config.TextColor,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        Size = size,
        Position = position,
        AutoButtonColor = true
    }, parent)

    Corner(button, 7)
    return button
end

-- LOADING SCREEN

local Loading = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Config.BackgroundColor,
    ZIndex = 20
}, Screen)

local LoadingIcon = Create("ImageLabel", {
    BackgroundTransparency = 1,
    Image = Config.Icon,
    Size = UDim2.fromOffset(95, 95),
    Position = UDim2.new(0.5, -47, 0.5, -85),
    ZIndex = 21
}, Loading)

local LoadingTitle = Create("TextLabel", {
    BackgroundTransparency = 1,
    Text = "LA PEACE HUB",
    TextColor3 = Config.TextColor,
    Font = Enum.Font.GothamBold,
    TextSize = 23,
    Size = UDim2.new(1, 0, 0, 35),
    Position = UDim2.new(0, 0, 0.5, 20),
    ZIndex = 21
}, Loading)

local LoadingText = Create("TextLabel", {
    BackgroundTransparency = 1,
    Text = "Initializing...",
    TextColor3 = Config.Muted,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    Size = UDim2.new(1, 0, 0, 25),
    Position = UDim2.new(0, 0, 0.5, 55),
    ZIndex = 21
}, Loading)

local ProgressBG = Create("Frame", {
    BackgroundColor3 = Config.PanelColor,
    Size = UDim2.fromOffset(190, 5),
    Position = UDim2.new(0.5, -95, 0.5, 90)
}, Loading)

Corner(ProgressBG, 5)

local Progress = Create("Frame", {
    BackgroundColor3 = Config.Accent,
    Size = UDim2.fromScale(0, 1)
}, ProgressBG)

Corner(Progress, 5)

TweenService:Create(
    Progress,
    TweenInfo.new(1.5),
    {Size = UDim2.fromScale(1, 1)}
):Play()

-- MAIN WINDOW

local Window = Create("Frame", {
    Name = "MainWindow",
    Size = UDim2.fromOffset(620, 410),
    Position = UDim2.new(0.5, -310, 0.5, -205),
    BackgroundColor3 = Config.BackgroundColor,
    BorderSizePixel = 0,
    Visible = false,
    ClipsDescendants = true
}, Screen)

Corner(Window, 12)
Stroke(Window, Color3.fromRGB(65, 72, 90), 0.25)

-- BACKGROUND IMAGE

local Wallpaper = Create("ImageLabel", {
    Name = "Wallpaper",
    BackgroundTransparency = 1,
    Image = Config.Background,
    ImageTransparency = 0.84,
    ScaleType = Enum.ScaleType.Crop,
    Size = UDim2.fromScale(1, 1),
    ZIndex = 0
}, Window)

-- HEADER

local Header = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 43),
    BackgroundColor3 = Color3.fromRGB(29, 37, 52),
    BackgroundTransparency = 0.05,
    BorderSizePixel = 0,
    ZIndex = 2
}, Window)

local HeaderIcon = Create("ImageLabel", {
    BackgroundTransparency = 1,
    Image = Config.Icon,
    Size = UDim2.fromOffset(27, 27),
    Position = UDim2.fromOffset(10, 8),
    ZIndex = 3
}, Header)

Label(
    Header,
    "LA PEACE HUB",
    UDim2.new(0, 180, 1, 0),
    UDim2.fromOffset(45, 0),
    14
).ZIndex = 3

local Minimize = Button(
    Header, "—",
    UDim2.fromOffset(32, 27),
    UDim2.new(1, -75, 0, 8)
)

Minimize.ZIndex = 4

local Close = Button(
    Header, "X",
    UDim2.fromOffset(32, 27),
    UDim2.new(1, -38, 0, 8)
)

Close.BackgroundColor3 = Color3.fromRGB(150, 55, 60)
Close.ZIndex = 4

-- SIDEBAR

local Sidebar = Create("Frame", {
    Size = UDim2.new(0, 145, 1, -43),
    Position = UDim2.fromOffset(0, 43),
    BackgroundColor3 = Color3.fromRGB(20, 23, 30),
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ZIndex = 2
}, Window)

local SidebarTitle = Label(
    Sidebar,
    "NAVIGATION",
    UDim2.new(1, -20, 0, 30),
    UDim2.fromOffset(12, 10),
    10
)

SidebarTitle.TextColor3 = Config.Muted

-- CONTENT

local Content = Create("Frame", {
    Size = UDim2.new(1, -155, 1, -53),
    Position = UDim2.fromOffset(150, 48),
    BackgroundTransparency = 1,
    ZIndex = 2
}, Window)

local Pages = {}

local function NewPage(name)
    local page = Create("Frame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Visible = false
    }, Content)

    Pages[name] = page
    return page
end

local Home = NewPage("Home")
local Hub = NewPage("ScriptHub")
local Assets = NewPage("Assets")
local Settings = NewPage("Settings")

local function ShowPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = pageName == name
    end
end

-- HOME PAGE

Label(
    Home,
    "Welcome to LA PEACE",
    UDim2.new(1, -20, 0, 35),
    UDim2.fromOffset(10, 12),
    22
)

Label(
    Home,
    "Universal Script & Asset Manager",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(10, 48),
    12
).TextColor3 = Config.Muted

local Info = Create("Frame", {
    Size = UDim2.new(1, -20, 0, 110),
    Position = UDim2.fromOffset(10, 95),
    BackgroundColor3 = Config.PanelColor,
    BackgroundTransparency = 0.12
}, Home)

Corner(Info, 10)

Label(
    Info,
    "LA PEACE HUB",
    UDim2.new(1, -20, 0, 30),
    UDim2.fromOffset(12, 10),
    17
)

Label(
    Info,
    "Created by Kai",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(12, 40),
    12
).TextColor3 = Config.Muted

Label(
    Info,
    "Version 0.1.0 | Initial Release",
    UDim2.new(1, -20, 0, 22),
    UDim2.fromOffset(12, 68),
    11
).TextColor3 = Config.Muted

-- SCRIPT HUB PAGE

Label(
    Hub,
    "Script Library",
    UDim2.new(1, -20, 0, 35),
    UDim2.fromOffset(10, 10),
    21
)

Label(
    Hub,
    "Your authorized script collection",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(10, 45),
    12
).TextColor3 = Config.Muted

local HubMessage = Create("TextLabel", {
    BackgroundColor3 = Config.PanelColor,
    Text = "Your script library is currently empty.",
    TextColor3 = Config.Muted,
    TextSize = 13,
    Font = Enum.Font.Gotham,
    Size = UDim2.new(1, -20, 0, 100),
    Position = UDim2.fromOffset(10, 85),
    TextWrapped = true
}, Hub)

Corner(HubMessage, 9)

-- ASSET MANAGER PAGE

Label(
    Assets,
    "Asset Manager",
    UDim2.new(1, -20, 0, 35),
    UDim2.fromOffset(10, 10),
    21
)

Label(
    Assets,
    "Manage authorized project backups",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(10, 45),
    12
).TextColor3 = Config.Muted

local ScanButton = Button(
    Assets,
    "Scan Workspace",
    UDim2.fromOffset(145, 34),
    UDim2.fromOffset(10, 85)
)

local ScanResult = Create("TextLabel", {
    BackgroundColor3 = Config.PanelColor,
    Text = "Ready to scan accessible Workspace instances.",
    TextColor3 = Config.Muted,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    Size = UDim2.new(1, -20, 0, 85),
    Position = UDim2.fromOffset(10, 130),
    TextWrapped = true
}, Assets)

Corner(ScanResult, 8)

local function ScanWorkspace()
    local total = 0
    local skipped = 0

    for _, object in ipairs(workspace:GetDescendants()) do
        if object:IsA("Animation")
            or object:IsA("AnimationController") then
            skipped += 1
        else
            total += 1
        end
    end

    ScanResult.Text =
        "Workspace scan complete.\n" ..
        "Accessible instances: " .. total .. "\n" ..
        "Excluded animation objects: " .. skipped ..
        "\nThis is a scan, not a saved backup."
end

ScanButton.MouseButton1Click:Connect(ScanWorkspace)

-- SETTINGS PAGE

Label(
    Settings,
    "Settings",
    UDim2.new(1, -20, 0, 35),
    UDim2.fromOffset(10, 10),
    21
)

local WallpaperToggle = Button(
    Settings,
    "Toggle Wallpaper",
    UDim2.fromOffset(155, 36),
    UDim2.fromOffset(10, 65)
)

WallpaperToggle.MouseButton1Click:Connect(function()
    Wallpaper.Visible = not Wallpaper.Visible
end)

local VersionLabel = Label(
    Settings,
    "LA PEACE HUB v0.1.0",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(10, 115),
    12
)

VersionLabel.TextColor3 = Config.Muted

-- NAVIGATION BUTTONS

local Navigation = {
    {"Home", "Home"},
    {"Script Hub", "ScriptHub"},
    {"Assets", "Assets"},
    {"Settings", "Settings"}
}

for index, item in ipairs(Navigation) do
    local button = Button(
        Sidebar,
        item[1],
        UDim2.new(1, -16, 0, 35),
        UDim2.fromOffset(8, 48 + (index - 1) * 43)
    )

    button.MouseButton1Click:Connect(function()
        ShowPage(item[2])
    end)
end

ShowPage("Home")

-- FLOATING REOPEN BUTTON

local Reopen = Button(
    Screen,
    "LP",
    UDim2.fromOffset(48, 48),
    UDim2.new(0, 20, 0.5, -24)
)

Reopen.BackgroundColor3 = Config.Accent
Reopen.Visible = false
Corner(Reopen, 24)

-- WINDOW CONTROLS

Close.MouseButton1Click:Connect(function()
    Window.Visible = false
    Reopen.Visible = true
end)

Minimize.MouseButton1Click:Connect(function()
    Window.Visible = false
    Reopen.Visible = true
end)

Reopen.MouseButton1Click:Connect(function()
    Window.Visible = true
    Reopen.Visible = false
end)

-- DRAGGABLE WINDOW

local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Window.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging then
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - dragStart

            Window.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- RESIZE HANDLE

local ResizeHandle = Create("TextButton", {
    Text = "◢",
    TextSize = 16,
    TextColor3 = Config.Muted,
    BackgroundColor3 = Config.PanelColor,
    Size = UDim2.fromOffset(23, 23),
    Position = UDim2.new(1, -23, 1, -23),
    ZIndex = 5
}, Window)

local resizing = false
local resizeStart
local originalSize

ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        resizing = true
        resizeStart = input.Position
        originalSize = Window.Size
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing then
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - resizeStart

            Window.Size = UDim2.fromOffset(
                math.max(350, originalSize.X.Offset + delta.X),
                math.max(260, originalSize.Y.Offset + delta.Y)
            )
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

-- INITIALIZE

task.wait(1.6)

Window.Visible = true

TweenService:Create(
    Loading,
    TweenInfo.new(0.4),
    {BackgroundTransparency = 1}
):Play()

task.wait(0.4)
Loading:Destroy()

print("[LA PEACE HUB] Initialized successfully.")
