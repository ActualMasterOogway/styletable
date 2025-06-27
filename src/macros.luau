local types = require(script.Parent["init.types"])

--[=[
    One argument: All.
    Two arguments: Top-Bottom, Left-Right.
    Three arguments: Top, Left-Right, Bottom.
    Four arguments: Top, Right, Bottom, Left.
]=]
local function Padding(one: UDim, two: UDim?, three: UDim?, four: UDim?): types.StyleTableRule
    local top = one
    local right = two or one
    local bottom = three or one
    local left = four or two or one

    return {
        ["::UIPadding"] = {
            PaddingTop = top,
            PaddingRight = right,
            PaddingBottom = bottom,
            PaddingLeft = left
        }
    }
end

local function CornerRadius(cornerRadius: UDim): types.StyleTableRule
    return {
        ["::UICorner"] = {
            CornerRadius = cornerRadius
        }
    }
end

local function Scale(scale: number): types.StyleTableRule
    return {
        ["::UIScale"] = {
            Scale = scale
        }
    }
end

return {
    Padding = Padding,
    CornerRadius = CornerRadius,
    Scale = Scale
}
