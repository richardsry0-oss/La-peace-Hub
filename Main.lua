
--[[
    LA PEACE HUB
    By Kai
    Version 0.2.0
    Complete UI redesign
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- CONFIG

local C = {
    Name = "LA PEACE HUB",
    Version = "0.2.0",
    Icon = "rbxassetid://108294449126537",
    Wallpaper = "rbxassetid://17582945598",

    Background = Color3.fromRGB(12, 16, 25),
    Panel = Color3.fromRGB(20, 27, 40),
    Panel2 = Color3.fromRGB(28, 38, 55),
    Blue = Color3.fromRGB(54, 139, 240),
    Cyan = Color3.fromRGB(75, 190, 255),
    White = Color3.fromRGB(245, 248, 255),
    Gray = Color3.fromRGB(155, 170, 190),
    Red = Color3.fromRGB(225, 75, 85),
    Green = Color3.fromRGB(75, 200, 135)
}

-- CLEANUP

local old = PlayerGui:FindFirstChild("LaPeaceHub")

if old then
    old:Destroy()
end

-- HELPERS

local function New(class, props, parent)
    local obj = Instance.new(class)

    for k, v in pairs(props or {}) do
        obj[k] = v
    end

    obj.Parent = parent
    return obj
end

local function Round(obj, radius)
    New("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function Outline(obj, color, transparency)
    New("UIStroke", {
        Color = color or C.Blue,
        Transparency = transparency or 0.6,
        Thickness = 1
    }, obj)
end

local function Gradient(obj, first, second, rotation)
    New("UIGradient", {
        Color = ColorSequence.new(first, second),
        Rotation = rotation or 0
    }, obj)
end

local function Text(parent, value, size, position, fontSize, color)
    return New("TextLabel", {
        BackgroundTransparency = 1,
        Text = value,
        TextSize = fontSize or 13,
        Font = Enum.Font.Gotham,
        TextColor3 = color or C.White,
        Size = size,
        Position = position,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true
    }, parent)
end

local function NewButton(parent, value, size, position, color)
    local b = New("TextButton", {
        BackgroundColor3 = color or C.Panel2,
        Text = value,
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        TextColor3 = C.White,
        Size = size,
        Position = position,
        AutoButtonColor = true,
        BorderSizePixel = 0
    }, parent)

    Round(b, 8)
    return b
end

local function Tween(obj, duration, properties)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(duration, Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out),
        properties
    )
    t:Play()
    return t
end

-- ROOT

local GUI = New("ScreenGui", {
    Name = "LaPeaceHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999
}, PlayerGui)

-- LOADING SCREEN

local Loading = New("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    ZIndex = 100
}, GUI)

local LoadIcon = New("ImageLabel", {
    BackgroundTransparency = 1,
    Image = C.Icon,
    Size = UDim2.fromOffset(100, 100),
    Position = UDim2.new(0.5, -50, 0.5, -105),
    ImageTransparency = 1,
    ZIndex = 101
}, Loading)

local LoadTitle = Text(
    Loading, "LA PEACE HUB",
    UDim2.new(1, 0, 0, 40),
    UDim2.new(0, 0, 0.5, 5), 24
)
LoadTitle.TextXAlignment = Enum.TextXAlignment.Center
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.ZIndex = 101

local LoadStatus = Text(
    Loading, "Initializing interface...",
    UDim2.new(1, 0, 0, 25),
    UDim2.new(0, 0, 0.5, 42), 11, C.Gray
)
LoadStatus.TextXAlignment = Enum.TextXAlignment.Center
LoadStatus.ZIndex = 101

local BarBG = New("Frame", {
    Size = UDim2.fromOffset(210, 5),
    Position = UDim2.new(0.5, -105, 0.5, 85),
    BackgroundColor3 = C.Panel2,
    BorderSizePixel = 0,
    ZIndex = 101
}, Loading)
Round(BarBG, 5)

local Bar = New("Frame", {
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = C.Cyan,
    BorderSizePixel = 0,
    ZIndex = 102
}, BarBG)
Round(Bar, 5)
Gradient(Bar, C.Blue, C.Cyan)

Tween(LoadIcon, 0.8, {ImageTransparency = 0})

task.spawn(function()
    for i = 1, 4 do
        LoadStatus.Text = ({
            "Initializing interface...",
            "Loading LA PEACE assets...",
            "Preparing workspace...",
            "Almost ready..."
        })[i]

        Tween(Bar, 0.4, {
            Size = UDim2.fromScale(i / 4, 1)
        })

        task.wait(0.4)
    end

    task.wait(0.3)

    Tween(Loading, 0.5, {
        BackgroundTransparency = 1
    })

    task.wait(0.55)
    Loading:Destroy()
end)

-- MAIN WINDOW

local Window = New("Frame", {
    Name = "MainWindow",
    Size = UDim2.new(0.94, 0, 0.78, 0),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, GUI)

New("UISizeConstraint", {
    MinSize = Vector2.new(320, 380),
    MaxSize = Vector2.new(900, 700)
}, Window)

Round(Window, 14)
Outline(Window, C.Blue, 0.35)

-- WALLPAPER

local Wallpaper = New("ImageLabel", {
    Name = "XPWallpaper",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = C.Wallpaper,
    ScaleType = Enum.ScaleType.Crop,
    ImageTransparency = 0.28,
    ZIndex = 0
}, Window)

local WallpaperOverlay = New("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = C.Background,
    BackgroundTransparency = 0.17,
    BorderSizePixel = 0,
    ZIndex = 1
}, Window)

-- HEADER

local Header = New("Frame", {
    Size = UDim2.new(1, 0, 0, 49),
    BackgroundColor3 = Color3.fromRGB(18, 30, 49),
    BackgroundTransparency = 0.05,
    BorderSizePixel = 0,
    ZIndex = 5
}, Window)

Gradient(Header, Color3.fromRGB(30, 65, 105),
    Color3.fromRGB(15, 25, 43))

local Logo = New("ImageLabel", {
    BackgroundTransparency = 1,
    Image = C.Icon,
    Size = UDim2.fromOffset(33, 33),
    Position = UDim2.fromOffset(10, 8),
    ZIndex = 7
}, Header)

local HeaderTitle = Text(
    Header, "LA PEACE HUB",
    UDim2.new(0.5, -40, 1, 0),
    UDim2.fromOffset(51, 0), 14
)
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.ZIndex = 7

local HeaderVersion = Text(
    Header, "v0.2.0",
    UDim2.fromOffset(55, 25),
    UDim2.new(0.5, 4, 0, 12), 10, C.Gray
)
HeaderVersion.ZIndex = 7

local MinButton = NewButton(
    Header, "—", UDim2.fromOffset(32, 29),
    UDim2.new(1, -76, 0, 10)
)
MinButton.ZIndex = 8

local CloseButton = NewButton(
    Header, "×", UDim2.fromOffset(32, 29),
    UDim2.new(1, -39, 0, 10), C.Red
)
CloseButton.ZIndex = 8

-- SIDEBAR

local Sidebar = New("Frame", {
    Size = UDim2.new(0, 116, 1, -49),
    Position = UDim2.fromOffset(0, 49),
    BackgroundColor3 = Color3.fromRGB(13, 19, 30),
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ZIndex = 4
}, Window)

local NavTitle = Text(
    Sidebar, "MENU",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(10, 13), 10, C.Gray
)

-- CONTENT

local Content = New("Frame", {
    Size = UDim2.new(1, -126, 1, -60),
    Position = UDim2.fromOffset(121, 54),
    BackgroundTransparency = 1,
    ZIndex = 3
}, Window)

local Pages = {}

local function MakePage(name)
    local p = New("ScrollingFrame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = C.Blue,
        CanvasSize = UDim2.fromOffset(0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false
    }, Content)

    New("UIPadding", {
        PaddingLeft = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 9),
        PaddingTop = UDim.new(0, 7),
        PaddingBottom = UDim.new(0, 15)
    }, p)

    New("UIListLayout", {
        Padding = UDim.new(0, 11),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, p)

    Pages[name] = p
    return p
end

local Home = MakePage("Home")
local ScriptHub = MakePage("ScriptHub")
local AssetManager = MakePage("AssetManager")
local SavedFiles = MakePage("SavedFiles")
local Settings = MakePage("Settings")

local function PageTitle(page, title, subtitle)
    local holder = New("Frame", {
        Size = UDim2.new(1, 0, 0, 62),
        BackgroundTransparency = 1
    }, page)

    Text(holder, title,
        UDim2.new(1, 0, 0, 34),
        UDim2.fromOffset(0, 0), 21).Font =
        Enum.Font.GothamBold

    Text(holder, subtitle,
        UDim2.new(1, 0, 0, 24),
        UDim2.fromOffset(0, 33), 11, C.Gray)
end

local function Card(parent, height)
    local card = New("Frame", {
        Size = UDim2.new(1, 0, 0, height),
        BackgroundColor3 = C.Panel,
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0
    }, parent)

    Round(card, 10)
    Outline(card, C.Blue, 0.76)

    return card
end

-- HOME

PageTitle(Home, "Welcome to LA PEACE",
    "Your personal script and asset management hub.")

local Welcome = Card(Home, 125)

local WelcomeIcon = New("ImageLabel", {
    BackgroundTransparency = 1,
    Image = C.Icon,
    Size = UDim2.fromOffset(75, 75),
    Position = UDim2.fromOffset(12, 25)
}, Welcome)

Text(Welcome, "LA PEACE HUB",
    UDim2.new(1, -105, 0, 30),
    UDim2.fromOffset(98, 27), 17).Font =
    Enum.Font.GothamBold

Text(Welcome, "Created by Kai",
    UDim2.new(1, -105, 0, 25),
    UDim2.fromOffset(98, 56), 11, C.Gray)

Text(Welcome, "Version 0.2.0",
    UDim2.new(1, -105, 0, 22),
    UDim2.fromOffset(98, 80), 10, C.Cyan)

local Status = Card(Home, 75)

Text(Status, "SYSTEM STATUS",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(12, 8), 10, C.Gray)

local StatusText = Text(Status, "●  Interface initialized",
    UDim2.new(1, -20, 0, 27),
    UDim2.fromOffset(12, 34), 12, C.Green)

local Quick = Card(Home, 88)

Text(Quick, "QUICK ACCESS",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(12, 6), 10, C.Gray)

local QuickScripts = NewButton(
    Quick, "Script Hub",
    UDim2.new(0.46, 0, 0, 35),
    UDim2.new(0.03, 0, 0, 42), C.Panel2
)

local QuickAssets = NewButton(
    Quick, "Assets",
    UDim2.new(0.46, 0, 0, 35),
    UDim2.new(0.51, 0, 0, 42), C.Blue
)

-- SCRIPT HUB

PageTitle(ScriptHub, "Script Hub",
    "Browse your own authorized script collection.")

local SearchBox = New("TextBox", {
    Size = UDim2.new(1, 0, 0, 39),
    BackgroundColor3 = C.Panel,
    Text = "",
    PlaceholderText = "Search scripts...",
    PlaceholderColor3 = C.Gray,
    TextColor3 = C.White,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    ClearTextOnFocus = false
}, ScriptHub)
Round(SearchBox, 8)
Outline(SearchBox, C.Blue, 0.75)

local EmptyScripts = Card(ScriptHub, 100)

local EmptyText = Text(
    EmptyScripts,
    "Your script library is empty.\nAdd scripts for projects you own.",
    UDim2.new(1, -20, 1, -20),
    UDim2.fromOffset(10, 10), 12, C.Gray
)
EmptyText.TextXAlignment = Enum.TextXAlignment.Center

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    if SearchBox.Text == "" then
        EmptyText.Text =
            "Your script library is empty.\nAdd scripts for projects you own."
    else
        EmptyText.Text =
            "No matching scripts found.\nYour library is currently empty."
    end
end)

-- ASSET MANAGER

PageTitle(AssetManager, "Asset Manager",
    "Inspect accessible instances in your own experience.")

local ScanCard = Card(AssetManager, 155)

Text(ScanCard, "WORKSPACE SCANNER",
    UDim2.new(1, -20, 0, 28),
    UDim2.fromOffset(12, 8), 12).Font =
    Enum.Font.GothamBold

Text(ScanCard, "Inspect accessible Workspace objects.",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(12, 35), 10, C.Gray)

local ScanButton = NewButton(
    ScanCard, "Scan Workspace",
    UDim2.new(1, -24, 0, 36),
    UDim2.fromOffset(12, 68), C.Blue
)

local ScanOutput = Text(
    ScanCard,
    "Waiting for scan...",
    UDim2.new(1, -24, 0, 35),
    UDim2.fromOffset(12, 111), 10, C.Gray
)

local LatestReport = nil
local Snapshots = {}

ScanButton.MouseButton1Click:Connect(function()
    ScanButton.Text = "Scanning..."
    ScanButton.Active = false

    task.wait(0.15)

    local counts = {}
    local total = 0
    local excluded = 0

    for _, object in ipairs(workspace:GetDescendants()) do
        if object:IsA("Animation")
            or object:IsA("AnimationController") then
            excluded += 1
        else
            total += 1
            counts[object.ClassName] =
                (counts[object.ClassName] or 0) + 1
        end
    end

    LatestReport = {
        Name = "Workspace Scan",
        Date = os.date("%Y-%m-%d %H:%M"),
        Total = total,
        Excluded = excluded,
        Classes = counts
    }

    ScanOutput.Text =
        "Instances: " .. total ..
        " | Excluded: " .. excluded

    ScanButton.Text = "Scan Again"
    ScanButton.Active = true

    StatusText.Text = "●  Workspace scan completed"
end)

local SaveReport = NewButton(
    AssetManager, "Save Scan Report",
    UDim2.new(1, 0, 0, 39),
    UDim2.fromOffset(0, 0), C.Blue
)

SaveReport.MouseButton1Click:Connect(function()
    if not LatestReport then
        ScanOutput.Text = "Scan Workspace first."
        return
    end

    local report = table.clone(LatestReport)
    report.Name = "Backup_" .. tostring(#Snapshots + 1)

    table.insert(Snapshots, report)

    StatusText.Text = "●  Scan report saved in session"
    ScanOutput.Text = "Report saved: " .. report.Name
end)

-- SAVED FILES

PageTitle(SavedFiles, "Saved Files",
    "Manage your current session's scan reports.")

local FileList = New("Frame", {
    Size = UDim2.new(1, 0, 0, 20),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1
}, SavedFiles)

local FileLayout = New("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, FileList)

local function RefreshFiles()
    for _, child in ipairs(FileList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    if #Snapshots == 0 then
        local empty = Card(FileList, 75)
        Text(empty, "No saved reports yet.",
            UDim2.new(1, -20, 1, 0),
            UDim2.fromOffset(10, 0), 12, C.Gray)
        return
    end

    for index, report in ipairs(Snapshots) do
        local row = Card(FileList, 115)
        row.LayoutOrder = index

        Text(row, report.Name,
            UDim2.new(1, -20, 0, 25),
            UDim2.fromOffset(10, 6), 12).Font =
            Enum.Font.GothamBold

        Text(row, report.Date .. " | " .. report.Total .. " instances",
            UDim2.new(1, -20, 0, 20),
            UDim2.fromOffset(10, 29), 10, C.Gray)

        local Load = NewButton(
            row, "View", UDim2.new(0.29, 0, 0, 30),
            UDim2.new(0.025, 0, 0, 72), C.Blue
        )

        local Rename = NewButton(
            row, "Rename", UDim2.new(0.29, 0, 0, 30),
            UDim2.new(0.355, 0, 0, 72)
        )

        local Delete = NewButton(
            row, "Delete", UDim2.new(0.29, 0, 0, 30),
            UDim2.new(0.685, 0, 0, 72), C.Red
        )

        Load.MouseButton1Click:Connect(function()
            ScanOutput.Text =
                "Loaded report: " .. report.Name ..
                " (" .. report.Total .. " instances)"
            StatusText.Text = "●  Report viewed"
        end)

        Rename.MouseButton1Click:Connect(function()
            local dialog = New("Frame", {
                Size = UDim2.new(0.8, 0, 0, 145),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = C.Panel2,
                ZIndex = 40
            }, Window)

            Round(dialog, 10)
            Outline(dialog, C.Blue, 0.2)

            local input = New("TextBox", {
                Size = UDim2.new(1, -20, 0, 35),
                Position = UDim2.fromOffset(10, 12),
                BackgroundColor3 = C.Background,
                Text = report.Name,
                TextColor3 = C.White,
                PlaceholderText = "New name",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ClearTextOnFocus = false,
                ZIndex = 41
            }, dialog)

            Round(input, 7)

            local confirm = NewButton(
                dialog, "Confirm",
                UDim2.new(0.45, 0, 0, 32),
                UDim2.new(0.025, 0, 0, 92), C.Blue
            )
            confirm.ZIndex = 42

            local cancel = NewButton(
                dialog, "Cancel",
                UDim2.new(0.45, 0, 0, 32),
                UDim2.new(0.525, 0, 0, 92), C.Red
            )
            cancel.ZIndex = 42

            confirm.MouseButton1Click:Connect(function()
                if input.Text:gsub("%s+", "") ~= "" then
                    report.Name = input.Text
                    RefreshFiles()
                end
                dialog:Destroy()
            end)

            cancel.MouseButton1Click:Connect(function()
                dialog:Destroy()
            end)
        end)

        Delete.MouseButton1Click:Connect(function()
            table.remove(Snapshots, index)
            RefreshFiles()
            StatusText.Text = "●  Report deleted"
        end)
    end
end

RefreshFiles()

-- SETTINGS

PageTitle(Settings, "Settings",
    "Customize your LA PEACE experience.")

local WallpaperCard = Card(Settings, 75)

Text(WallpaperCard, "Windows XP Wallpaper",
    UDim2.new(1, -100, 0, 30),
    UDim2.fromOffset(12, 10), 12)

local WallpaperToggle = NewButton(
    WallpaperCard, "ON",
    UDim2.fromOffset(65, 30),
    UDim2.new(1, -77, 0, 20), C.Green
)

WallpaperToggle.MouseButton1Click:Connect(function()
    Wallpaper.Visible = not Wallpaper.Visible
    WallpaperOverlay.Visible = Wallpaper.Visible
    WallpaperToggle.Text = Wallpaper.Visible and "ON" or "OFF"
    WallpaperToggle.BackgroundColor3 =
        Wallpaper.Visible and C.Green or C.Red
end)

local InfoCard = Card(Settings, 95)

Text(InfoCard, "ABOUT LA PEACE HUB",
    UDim2.new(1, -20, 0, 25),
    UDim2.fromOffset(12, 8), 11).Font =
    Enum.Font.GothamBold

Text(InfoCard, "Developer: Kai\nVersion: 0.2.0\nInterface: Mobile First",
    UDim2.new(1, -20, 0, 60),
    UDim2.fromOffset(12, 32), 10, C.Gray)

-- NAVIGATION

local Navigation = {
    {"⌂", "Home", Home},
    {"▤", "Scripts", ScriptHub},
    {"◈", "Assets", AssetManager},
    {"▣", "Saved", SavedFiles},
    {"⚙", "Settings", Settings}
}

local SelectedButton

local function ShowPage(page, button)
    for _, p in pairs(Pages) do
        p.Visible = false
    end

    page.Visible = true

    if SelectedButton then
        SelectedButton.BackgroundColor3 =
            Color3.fromRGB(22, 29, 42)
    end

    SelectedButton = button
    button.BackgroundColor3 = C.Blue
end

for i, item in ipairs(Navigation) do
    local button = NewButton(
        Sidebar,
        item[1] .. "  " .. item[2],
        UDim2.new(1, -12, 0, 39),
        UDim2.fromOffset(6, 47 + (i - 1) * 47)
    )

    button.TextXAlignment = Enum.TextXAlignment.Left

    New("UIPadding", {
        PaddingLeft = UDim.new(0, 9)
    }, button)

    button.MouseButton1Click:Connect(function()
        ShowPage(item[3], button)
    end)

    item.Button = button
end

ShowPage(Home, Navigation[1].Button)

QuickScripts.MouseButton1Click:Connect(function()
    ShowPage(ScriptHub, Navigation[2].Button)
end)

QuickAssets.MouseButton1Click:Connect(function()
    ShowPage(AssetManager, Navigation[3].Button)
end)

-- WINDOW CONTROLS

local Reopen = NewButton(
    GUI, "LP",
    UDim2.fromOffset(52, 52),
    UDim2.new(0, 15, 0.5, -26), C.Blue
)

Reopen.Visible = false
Round(Reopen, 26)
Outline(Reopen, C.Cyan, 0.1)

local function HideWindow()
    Window.Visible = false
    Reopen.Visible = true
end

local function OpenWindow()
    Window.Visible = true
    Reopen.Visible = false
end

CloseButton.MouseButton1Click:Con
nect(HideWindow)
MinButton.MouseButton1Click:Connect(HideWindow)
Reopen.MouseButton1Click:Connect(OpenWindow)

-- DRAGGING
local dragging = false
local dragStart
local startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = Window.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        Window.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- RESIZING
local resizing = false
local resizeStart
local originalSize

Resize.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        resizing = true
        resizeStart = input.Position
        originalSize = Window.AbsoluteSize
    end
end)

UIS.InputChanged:Connect(function(input)
    if resizing and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - resizeStart

        Window.Size = UDim2.fromOffset(
            math.clamp(originalSize.X + delta.X, 320, 900),
            math.clamp(originalSize.Y + delta.Y, 380, 700)
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

-- INITIALIZATION
print("================================")
print("LA PEACE HUB v0.2.0")
print("Created by Kai")
print("Interface initialized!")
print("================================")
