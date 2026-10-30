-- LA PEACE HUB by Kai | Main.lua
-- UI-only starter for an experience you own. Place as a LocalScript in StarterPlayerScripts.
-- This does not execute external scripts, exploit games, or copy assets from other experiences.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GUI_NAME = "LaPeaceHubGui"
local oldGui = playerGui:FindFirstChild(GUI_NAME)
if oldGui then oldGui:Destroy() end

local COLORS = {
    background = Color3.fromRGB(15, 18, 25),
    panel = Color3.fromRGB(24, 29, 39),
    panel2 = Color3.fromRGB(31, 38, 51),
    accent = Color3.fromRGB(93, 145, 255),
    text = Color3.fromRGB(240, 243, 250),
    muted = Color3.fromRGB(157, 168, 187),
    stroke = Color3.fromRGB(55, 66, 86),
}

local function make(className, props, parent)
    local obj = Instance.new(className)
    for key, value in pairs(props or {}) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local function corner(parent, radius)
    make("UICorner", { CornerRadius = UDim.new(0, radius or 10) }, parent)
end

local function outline(parent, color, transparency)
    make("UIStroke", {
        Color = color or COLORS.stroke,
        Transparency = transparency or 0,
        Thickness = 1,
    }, parent)
end

local function label(parent, text, size, position, fontSize, color, bold)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Size = size,
        Position = position,
        Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham,
        Text = text,
        TextSize = fontSize or 14,
        TextColor3 = color or COLORS.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true,
    }, parent)
end

local function button(parent, text, size, position, callback)
    local b = make("TextButton", {
        Size = size,
        Position = position,
        BackgroundColor3 = COLORS.panel2,
        AutoButtonColor = true,
        Font = Enum.Font.GothamSemibold,
        Text = text,
        TextSize = 13,
        TextColor3 = COLORS.text,
    }, parent)
    corner(b, 9)
    outline(b)
    b.Activated:Connect(callback)
    return b
end

local gui = make("ScreenGui", {
    Name = GUI_NAME,
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

local window = make("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.52),
    Size = UDim2.new(0.92, 0, 0.76, 0),
    BackgroundColor3 = COLORS.background,
    ClipsDescendants = true,
}, gui)
corner(window, 14)
outline(window, COLORS.stroke)
make("UISizeConstraint", { MinSize = Vector2.new(300, 360), MaxSize = Vector2.new(760, 680) }, window)

local header = make("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = COLORS.panel,
    BorderSizePixel = 0,
}, window)

local icon = make("ImageLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(13, 10),
    Size = UDim2.fromOffset(38, 38),
    Image = "rbxassetid://108294449126537",
    ScaleType = Enum.ScaleType.Fit,
}, header)

label(header, "LA PEACE HUB", UDim2.new(1, -150, 0, 22), UDim2.fromOffset(60, 8), 16, COLORS.text, true)
label(header, "by Kai  •  UI preview", UDim2.new(1, -150, 0, 18), UDim2.fromOffset(60, 30), 10, COLORS.muted, false)

local closeButton = button(header, "×", UDim2.fromOffset(34, 32), UDim2.new(1, -44, 0, 13), function()
    window.Visible = false
end)
closeButton.TextSize = 22

local reopen = button(gui, "LP", UDim2.fromOffset(48, 48), UDim2.new(1, -62, 1, -70), function()
    window.Visible = true
end)
reopen.Visible = false
reopen.BackgroundColor3 = COLORS.accent
corner(reopen, 24)

closeButton.Activated:Connect(function()
    reopen.Visible = true
end)

local sidebar = make("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(10, 68),
    Size = UDim2.new(0, 116, 1, -80),
    BackgroundColor3 = COLORS.panel,
}, window)
corner(sidebar, 10)

local navLayout = make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, sidebar)
make("UIPadding", {
    PaddingTop = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
}, sidebar)

local content = make("Frame", {
    Name = "Content",
    Position = UDim2.new(0, 136, 0, 68),
    Size = UDim2.new(1, -146, 1, -80),
    BackgroundColor3 = COLORS.panel,
    ClipsDescendants = true,
}, window)
corner(content, 10)

local wallpaper = make("ImageLabel", {
    Name = "Wallpaper",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = "rbxassetid://17582945598",
    ScaleType = Enum.ScaleType.Crop,
    ImageTransparency = 0.68,
}, content)
corner(wallpaper, 10)

local shade = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = COLORS.background,
    BackgroundTransparency = 0.18,
    BorderSizePixel = 0,
}, content)
corner(shade, 10)

local pages = {}
local function createPage(name)
    local page = make("ScrollingFrame", {
        Name = name .. "Page",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = COLORS.accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, content)
    make("UIPadding", {
        PaddingTop = UDim.new(0, 16),
        PaddingLeft = UDim.new(0, 16),
        PaddingRight = UDim.new(0, 16),
        PaddingBottom = UDim.new(0, 16),
    }, page)
    make("UIListLayout", {
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, page)
    pages[name] = page
    return page
end

local function section(parent, title, description)
    local card = make("Frame", {
        Size = UDim2.new(1, 0, 0, 88),
        BackgroundColor3 = COLORS.panel2,
        BackgroundTransparency = 0.08,
    }, parent)
    corner(card, 10)
    outline(card)
    label(card, title, UDim2.new(1, -24, 0, 25), UDim2.fromOffset(12, 9), 14, COLORS.text, true)
    label(card, description, UDim2.new(1, -24, 0, 42), UDim2.fromOffset(12, 36), 11, COLORS.muted, false)
    return card
end

local home = createPage("Home")
section(home, "Welcome to LA PEACE HUB", "A clean mobile-first interface for tools inside your own Roblox experience.")
section(home, "Quick start", "Choose a section from the left navigation. This build is a safe UI foundation; connect your own game systems to its buttons.")

local hub = createPage("Script Hub")
section(hub, "Your tools", "Add buttons here for scripts and systems that you created or are authorized to use.")
section(hub, "No tools added yet", "This starter file does not download or execute third-party code.")

local assets = createPage("Asset Manager")
section(assets, "Asset manager", "Use this area to organize asset IDs belonging to your own project.")
section(assets, "Studio limitation", "A client UI cannot read ServerStorage or ServerScriptService, and this starter does not scan or copy other games.")

local saved = createPage("Saved Files")
section(saved, "Saved files", "No saved project records yet. Add a server-authorized save system for persistent data in your own experience.")

local settings = createPage("Settings")
section(settings, "Interface", "The window can be dragged. Use the × button to hide it and the LP button to reopen it.")

local function showPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end
    for _, child in ipairs(sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 = child.Name == name .. "Nav" and COLORS.accent or COLORS.panel2
        end
    end
end

local navNames = { "Home", "Script Hub", "Asset Manager", "Saved Files", "Settings" }
for index, name in ipairs(navNames) do
    local nav = button(sidebar, name, UDim2.new(1, 0, 0, 38), UDim2.new(), function()
        showPage(name)
    end)
    nav.Name = name .. "Nav"
    nav.LayoutOrder = index
    nav.TextSize = 11
end
showPage("Home")

-- Drag the window from its header; buttons remain usable.
local dragging = false
local dragInput
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = window.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

-- Small entrance animation.
window.BackgroundTransparency = 1
window.Size = UDim2.new(0.88, 0, 0.72, 0)
TweenService:Create(window, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0,
    Size = UDim2.new(0.92, 0, 0.76, 0),
}):Play()

print("[LA PEACE HUB] UI loaded successfully.")
