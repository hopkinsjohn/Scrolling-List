
table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
  Value = "None"
})

table.insert(props, { -- for enum property types
  Name = "List Buttons",
  Type = "integer",
  Min = 4,
  Max = 50,
  Value = 10,  -- Default Option
})

table.insert(props, { 
  Name = "Orientation",
  Type = "enum",
  Choices = {"Vertical", "Horizontal"},
  Value = "Vertical"  -- Default Option
})

table.insert(props, { -- for enum property types
  Name = "Scrolling Buttons",
  Type = "integer",
  Min = 2,
  Max = 10,
  Value = 5,  -- Default Option
})