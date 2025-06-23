export type StyleTable = {
    ["@derives"]: { StyleSheet }?,
    [string | number]: any | StyleTableRule | StyleTable,
}

export type StyleTableRule = {
    ["@priority"]: number?,
    [string | number]: any | StyleTableRule
}

export type StyleParent = StyleSheet | StyleRule

return nil