-- Run once in Roblox Studio's Command Bar after importing WorldIce.
local world = workspace:FindFirstChild("WorldIce")
assert(world, "WorldIce was not found in Workspace")

local colors = {
    snow = Color3.fromRGB(105, 145, 180),
    rock = Color3.fromRGB(42, 68, 82),
    water = Color3.fromRGB(0, 105, 185),
    tree = Color3.fromRGB(20, 92, 52),
    wood = Color3.fromRGB(125, 70, 28),
    road = Color3.fromRGB(65, 78, 88),
}

local changed = 0
for _, object in ipairs(world:GetDescendants()) do
    if object:IsA("BasePart") then
        local name = string.lower(object.Name)
        local group = name:match("roblox_([%a]+)")
        if not group then
            if name:find("waterfall") or name:find("water") then group = "water"
            elseif name:find("fir") or name:find("tree") or name:find("needle") then group = "tree"
            elseif name:find("road") then group = "road"
            elseif name:find("wood") or name:find("oak") then group = "wood"
            elseif name:find("rock") or name:find("stone") or name:find("cliff") then group = "rock"
            else group = "snow" end
        end
        local color = colors[group] or colors.snow
        object.Color = color
        object.Material = Enum.Material.SmoothPlastic
        object.Transparency = group == "water" and 0.08 or 0
        object.CastShadow = group ~= "water"
        pcall(function() object.TextureID = "" end)
        if group == "water" then object.CanCollide = false end
        changed += 1
    end
end
print("WorldIce colored parts:", changed)
