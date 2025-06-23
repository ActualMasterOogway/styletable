local types = require(script.Parent["init.types"])

--[=[
    One argument: All.
    Two arguments: Top-Bottom, Left-Right.
    Three arguments: Top, Left-Right, Bottom.
    Four arguments: Top, Right, Bottom, Left.
]=]
local function Padding(one: UDim, two: UDim?, three: UDim?, four: UDim?): types.StyleTableRule
    if one and two and three and four then
        return {
            ["::UIPadding"] = {
                PaddingTop = one,
                PaddingRight = two,
                PaddingBottom = three,
                PaddingLeft = four
            }
        }

    elseif one and two and three then
        return {
            ["::UIPadding"] = {
                PaddingTop = one,
                PaddingLeft = two,
                PaddingRight = two,
                PaddingBottom = three
            }
        }

    elseif one and two then
        return {
            ["::UIPadding"] = {
                PaddingTop = one;
                PaddingBottom = one;
                PaddingLeft = two;
                PaddingRight = two;
            }
        }

    else
        return {
            ["::UIPadding"] = {
                PaddingTop = one :: UDim,
                PaddingBottom = one :: UDim,
                PaddingLeft = one :: UDim,
                PaddingRight = one :: UDim
            }
        }
    end
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