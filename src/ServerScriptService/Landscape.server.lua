-- Первый прототип карты. Здесь пока только ландшафт и река.
-- Новые элементы будем добавлять после визуальной проверки основы.
local Workspace = game:GetService("Workspace")

local old = Workspace:FindFirstChild("MapPrototype")
if old then old:Destroy() end

local map = Instance.new("Folder")
map.Name = "MapPrototype"
map.Parent = Workspace

local function makePart(name, size, position, color, material, transparency)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = size
    part.Position = position
    part.Anchored = true
    part.Color = color
    part.Material = material or Enum.Material.SmoothPlastic
    part.TopSurface = Enum.SurfaceType.Smooth
    part.BottomSurface = Enum.SurfaceType.Smooth
    part.Transparency = transparency or 0
    part.Parent = map
    return part
end

local snow = Color3.fromRGB(183, 205, 218)
local bank = Color3.fromRGB(150, 177, 190)
local riverbed = Color3.fromRGB(55, 91, 105)
local water = Color3.fromRGB(48, 137, 178)
local rock = Color3.fromRGB(92, 120, 132)

-- Две непрерывные стороны долины оставляют русло свободным по всей длине.
makePart("WestBank", Vector3.new(51, 2, 150), Vector3.new(-34.5, -1, 0), snow, Enum.Material.Snow)
makePart("EastBank", Vector3.new(51, 2, 150), Vector3.new(34.5, -1, 0), snow, Enum.Material.Snow)
makePart("WestShore", Vector3.new(4, 1.2, 150), Vector3.new(-9.5, -0.55, 0), bank, Enum.Material.Slate)
makePart("EastShore", Vector3.new(4, 1.2, 150), Vector3.new(9.5, -0.55, 0), bank, Enum.Material.Slate)

-- Русло: постоянные ширина 18 studs и глубина 2.8 studs от водопада до выхода.
makePart("RiverBed", Vector3.new(18, 2.8, 150), Vector3.new(0, -2.2, 0), riverbed, Enum.Material.Slate)
local waterPart = makePart("RiverWater", Vector3.new(17.7, 0.22, 149.7), Vector3.new(0, -0.72, 0), water, Enum.Material.Glass, 0.2)
waterPart.CanCollide = false
waterPart.CanQuery = false

-- Простой равномерный водопад на верхнем краю прототипа.
makePart("WaterfallCliff", Vector3.new(28, 10, 5), Vector3.new(0, 3.5, 77.5), rock, Enum.Material.Slate)
local fall = makePart("Waterfall", Vector3.new(17.7, 8, 0.25), Vector3.new(0, 0.4, 74.8), water, Enum.Material.Glass, 0.2)
fall.CanCollide = false
fall.CanQuery = false

-- Мелкие одинаковые камни отмечают границу русла, без строительных точек.
for _, x in ipairs({-12, 12}) do
    for z = -66, 66, 12 do
        makePart("ShoreRock", Vector3.new(2, 0.9, 3), Vector3.new(x, 0.05, z), rock, Enum.Material.Slate)
    end
end

local lighting = game:GetService("Lighting")
lighting.ClockTime = 15
lighting.Brightness = 2
lighting.Ambient = Color3.fromRGB(150, 170, 185)
lighting.OutdoorAmbient = Color3.fromRGB(125, 145, 160)
