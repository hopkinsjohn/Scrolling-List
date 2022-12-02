
---------- Variables
local MaxButtons = 50
local MaxScrollingButtons = 10
local TotalButtonCount = props["List Buttons"].Value
local ScrollingButtonCount = props["Scrolling Buttons"].Value
local Orientation = props["Orientation"].Value

if Orientation == "Vertical" then
  SliderMaxValue = TotalButtonCount
  SliderMinValue = ScrollingButtonCount
else
  SliderMaxValue = ScrollingButtonCount
  SliderMinValue = TotalButtonCount
end

-- all options
table.insert(ctrls, {
  Name = "Button",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = MaxButtons,
  UserPin = true,
  PinStyle = "Output",
})
table.insert(ctrls, {
  Name = "Trigger",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = MaxButtons,
  UserPin = true,
  PinStyle = "Both",
})
table.insert(ctrls, {
  Name = "Legend",
  ControlType = "Text",
  Count = MaxButtons,
  UserPin = true,
  PinStyle = "Both",
})
table.insert(ctrls, {
  Name = "Value",
  ControlType = "Text",
  Count = MaxButtons,
  UserPin = true,
  PinStyle = "Both",
})


-- scrolling options
table.insert(ctrls, {
  Name = "Scrolling Button",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = MaxScrollingButtons,
  UserPin = true,
  PinStyle = "Output",
})
table.insert(ctrls, {
  Name = "Scrolling Trigger",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = MaxScrollingButtons,
  UserPin = true,
  PinStyle = "Both",
})
table.insert(ctrls, {
  Name = "Scrolling Button Int",
  ControlType = "Indicator",
  IndicatorType = "Text",
  Count = MaxScrollingButtons,
  UserPin = false,
})
table.insert(ctrls,{
  Name = "Nav Up",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  IconType = "Icon",
  Icon = "Arrow Up"
})
table.insert(ctrls,{
  Name = "Nav Down",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  IconType = "Icon",
  Icon = "Arrow Down"
})
table.insert(ctrls,{
  Name = "Nav Left",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  IconType = "Icon",
  Icon = "Arrow Left"
})
table.insert(ctrls,{
  Name = "Nav Right",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  IconType = "Icon",
  Icon = "Arrow Right"
})
table.insert(ctrls,{
  Name = "Slider",
  ControlType = "Knob",
  Min = SliderMinValue, 
  --Max = 25,
  Max = SliderMaxValue,
  ControlUnit = "Integer",
  Count = 1,
  DefaultValue = 25,
  UserPin = true,
  PinStyle = "Input",
})

table.insert(ctrls,{
  Name = "Reset",
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  IconType = "Icon",
  Icon = "X Circle"
})


-- "output"
-- selection combobox
table.insert(ctrls, {
  Name = "ComboBox",
  ControlType = "Text",
  Count = 1,
  UserPin = false,
})
-- selected value
table.insert(ctrls, {
  Name = "Selected Value",
  ControlsType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both",
})
-- selected legend
table.insert(ctrls, {
  Name = "Selected Legend",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Both",
})
-- selected legend display
table.insert(ctrls, {
  Name = "Selected Legend Display",
  ControlType = "Indicator",
  IndicatorType = "Text",
  UserPin = false, 
})
-- user input has been entered
table.insert(ctrls, {
  Name = "User Input Flag",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = false,
})



