--!strict
--!optimize 2

export type StyleTable = {
    ["@derives"]: { StyleSheet }?,
    [string]: any
}

export type StyleTableRule = {
    ["@priority"]: number?,
    [string]: any | StyleTableRule
}

export type StyleParent = StyleSheet | StyleRule

local function ParseAttribute(key: any, value: any, parent: StyleParent): boolean
    if type(key) ~= "string" then return false end

    local _,_, attributeName = string.find(key, "^$([a-zA-Z%d_]+)")
    if not attributeName then return false end

    -- Attribute's can't start with RBX or be more than 100 characters.
    -- If this is the case then we return that parsing was successful -
    -- but we don't apply the attribute as that would cause an error.
    if string.match(attributeName, "^RBX") then return true end
    if #attributeName > 100 then return true end

    parent:SetAttribute(attributeName, value)

    return true
end

local function ParseProperty(key: any, value: any, parent: StyleRule): boolean
    if type(key) ~= "string" then return false end

    parent:SetProperty(key, value)

    return true
end

local function ParseRule(key: any, value: any, parent: StyleParent): boolean
    if type(key) ~= "string" or type(value) ~= "table" then return false end

    local styleRule = Instance.new("StyleRule")
    styleRule.Selector = key
    styleRule.Name = key

    local priority = value["@priority"]
    if priority then value["@priority"] = nil end

    for key, value in value do
        if ParseRule(key, value, styleRule) then continue end
        if ParseAttribute(key, value, styleRule) then continue end
        ParseProperty(key, value, styleRule)
    end

    styleRule.Parent = parent

    if priority then
        styleRule.Priority = priority
    end

    return true
end

local function ParseDerive(value: any, parent: StyleSheet): boolean
    if typeof(value) ~= "Instance" and value.ClassName ~= "StyleSheet" then return false end

    local derive = Instance.new("StyleDerive")
    derive.StyleSheet = value :: StyleSheet
    derive.Parent = parent

    return true
end

return function(styleTable: StyleTable)
    local styleSheet = Instance.new("StyleSheet")

    local derives = styleTable["@derives"]
    if derives then styleTable["@derives"] = nil end

    for key, value in styleTable do
        if ParseRule(key, value, styleSheet) then continue end
        ParseAttribute(key, value, styleSheet)
    end

    if type(derives) == "table" then
        for key, value in derives do
            ParseDerive(value, styleSheet)
        end
    end

    return styleSheet
end