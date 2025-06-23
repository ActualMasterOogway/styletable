--!strict
--!optimize 2

local StyleTable = require(script.Parent.Packages.StyleTable)
local StyleMacros = require(script.Parent.Packages.StyleTable.macros)
local Padding, CornerRadius, Scale = StyleMacros.Padding, StyleMacros.CornerRadius, StyleMacros.Scale

local AttributeStyles = StyleTable {
    ["$FontFace"] = Font.fromName("BuilderSans", Enum.FontWeight.SemiBold),
    ["$TextSize"] = 14,
    ["$ColorText"] = Color3.fromHex "f8fafc",
    ["$ColorPrimary"] = Color3.fromHex "1d4ed8",
    ["$ColorSecondary"] = Color3.fromHex "334155",
    ["$ColorDestructive"] = Color3.fromHex "be123c"
}
AttributeStyles.Parent = game:GetService("ReplicatedStorage")

local ButtonStyles = StyleTable {
    ["@derives"] = { AttributeStyles },

    [".Button"] = {
        ["@priority"] = 50,
        AutomaticSize = Enum.AutomaticSize.XY,
        FontFace = "$FontFace",
        TextColor3 = "$ColorText",
        TextSize = "$TextSize",
        CornerRadius (UDim.new(0, 8)),
        Padding (UDim.new(0, 10)),

        [".Primary"] = {
            BackgroundColor3 = "$ColorPrimary"
        },

        [".Secondary"] = {
            BackgroundColor3 = "$ColorSecondary"
        },

        [".Destructive"] = {
            BackgroundColor3 = "$ColorDestructive"
        },

        [".Disabled"] = {
            BackgroundTransparency = .4,
            Interactable = false
        }
    }
}
ButtonStyles.Parent = game:GetService("ReplicatedStorage")

local function CreateButton(
    variant: ("Primary" | "Secondary" | "Destructive")?,
    disabled: boolean?
)
    local button = Instance.new("TextButton")
    button:AddTag("Button")
    button:AddTag(variant or "Primary")
    if disabled then button:AddTag("Disabled") end

    local styleLink = Instance.new("StyleLink")
    styleLink.StyleSheet = ButtonStyles
    styleLink.Parent = button
    
    return button
end

local ScreenGui = Instance.new("ScreenGui")

local Button = CreateButton("Destructive", false)
Button.Text = "Delete!"
Button.Parent = ScreenGui

ScreenGui.Parent = game:GetService("StarterGui")