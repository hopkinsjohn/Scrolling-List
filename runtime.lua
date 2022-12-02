--[[ ************ Constants ************ ]]--
e = System.IsEmulating
DebugPrint = Properties["Debug Print"].Value
local MaxButtons = Properties["List Buttons"].Value -- this reads the property "Desired Buttons" and we use this below
local NumScrollingButtons = Properties["Scrolling Buttons"].Value -- this reads the property "Desired Buttons" and we use this below
local CurrentPosition = 0
Controls['Slider'].Position = 1
PressAndHoldTimer = Timer.New()
PressAndHoldVal1 = 0.3
PressAndHoldVal2 = 2.5/MaxButtons
PressAndHoldTimerInitialPress = false

--[[ ************ Tables ************ ]]--
ValueTable = {}
LegendTable = {}

--[[ ************ Functions ************ ]]--
-- A function to determine common print statement scenarios for troubleshooting
function SetupDebugPrint()
  if(DebugFunction)then print("SetupDebugPrint") end
  if DebugPrint=="Tx/Rx" then
    DebugTx,DebugRx=true,true
  elseif DebugPrint=="Tx" then
    DebugTx=true
  elseif DebugPrint=="Rx" then
    DebugRx=true
  elseif DebugPrint=="Function Calls" then
    DebugFunction=true
  elseif DebugPrint=="All" then
    DebugTx,DebugRx,DebugFunction=true,true,true
  end
end


-- A function for mutually exclusive button selections
function SetSelected(n)
  if(DebugFunction)then print("SetSelected entered with "..n)end
  for i, Ctrl in pairs(Controls["Button"]) do
    Ctrl.Boolean = (i == n)   --this looks at every Ctrl and asks "is i = n", and if it not then the boolean is false  
  end

  --update the controls to the last selected trigger, value, legend
  if n == 0 then
      Controls['Selected Value'].String = ""
      Controls['Selected Legend'].String = ""
      Controls['ComboBox'].String = ""
      Controls['Selected Legend Display'].String = ""
  else 
      Controls["Trigger"][n]:Trigger()
      Controls['Selected Value'].String = ValueTable[n]
      Controls['Selected Legend'].String = LegendTable[n]
      Controls['ComboBox'].String = LegendTable[n]
      Controls['Selected Legend Display'].String = LegendTable[n]
  end
  
  -- update the Scrolling Buttons
  UpdateScrollingButons()
end


-- A function to grab the strings in the legend inputs, and insert them into the "LegendTable" table
function UpdateLegendTable()
  if(DebugFunction)then 
    print ("UpdateLegendTable") 
    print (string.format("LegendTable has %u entries.", #LegendTable))
  end

  --clear the LegendTable first
  for idx in pairs (LegendTable) do
    LegendTable[idx] = nil
  end

  -- build the table
  for i = 1, MaxButtons do
    if(DebugFunction)then print (string.format(".\tEntry %u : %s", i, Controls['Legend'][i].String)) end
    table.insert(LegendTable, i, Controls['Legend'][i].String)
    Controls["Button"][i].Legend = LegendTable[i]
  end

  -- assign new table to the combobox
  Controls['ComboBox'].Choices = LegendTable

  -- update the Scrolling Buttons
  UpdateScrollingButons()
end


-- A function to grab the strings in the Value inputs, and insert them into the "ValueTable" table
function UpdateValueTable()
  if(DebugFunction)then 
    print ("UpdateValueTable") 
    print (string.format("ValueTable has %u entries.", #ValueTable))
  end

  --clear the table first
  for idx in pairs (ValueTable) do
    ValueTable[idx] = nil
  end

  -- build the table
  for i = 1, MaxButtons do
    if(DebugFunction)then print (string.format(".\tEntry %u : %s", i, Controls['Value'][i].String)) end
    table.insert(ValueTable, i, Controls['Value'][i].String)
  end

end

-- A function that updates the Scrolling Buttons Legends and Boolean
function UpdateScrollingButons(k)

  -- arg k was put here to catch when the slider calls this function
  local wasItSlider
  if k == nil then 
    wasItSlider = false
  else 
    wasItSlider = true
  end 

  for i = 1, NumScrollingButtons do 

      -- update button legend
      Controls['Scrolling Button'][i].Legend = LegendTable[CurrentPosition+i]

      -- update actual button index for reference
      Controls['Scrolling Button Int'][i].String = math.floor(CurrentPosition+i)

      -- update the scrolling button boolean
      if Controls['Button'][CurrentPosition+i].Boolean then 
        Controls['Scrolling Button'][i].Boolean = true
      else
        Controls['Scrolling Button'][i].Boolean = false
      end 

  end 
  if CurrentPosition == 0 then 
      Controls['Nav Up'].IsDisabled = true 
      Controls['Nav Left'].IsDisabled = true 
  else 
      Controls['Nav Up'].IsDisabled = false 
      Controls['Nav Left'].IsDisabled = false 
  end

  if CurrentPosition == MaxButtons-NumScrollingButtons then 
      Controls['Nav Down'].IsDisabled = true 
      Controls['Nav Right'].IsDisabled = true 
  else 
      Controls['Nav Down'].IsDisabled = false 
      Controls['Nav Right'].IsDisabled = false 
  end

  -- update slider
  if wasItSlider == false then
    Controls['Slider'].Value = MaxButtons-CurrentPosition
  end 
end 

function NavButtons(direction)
    if direction == "Up" then   
        if CurrentPosition > 0 then
          CurrentPosition = CurrentPosition - 1
          UpdateScrollingButons()
        end
    elseif direction == "Down" then 
        if CurrentPosition < MaxButtons-NumScrollingButtons then
          CurrentPosition = CurrentPosition + 1
          UpdateScrollingButons()
        end
    end
end 




--[[ ************ EventHandlers ************ ]]--
-- full button list selection button EH
for i, Ctrl in pairs (Controls["Button"]) do
  Ctrl.EventHandler = function()
    SetSelected(i)
  end
end

-- full button list selection button legend EH
for i, Ctrl in pairs (Controls['Legend']) do
  Ctrl.EventHandler = function()
    UpdateLegendTable()
    Controls['User Input Flag'].Boolean = true
  end
end

-- full button list selection button value EH
for i, Ctrl in pairs (Controls['Value']) do
  Ctrl.EventHandler = function()
    UpdateValueTable()
  end
end

-- full button list selection trigger EH
for i, Ctrl in pairs (Controls["Trigger"]) do
  Ctrl.EventHandler = function()
    SetSelected(i)
  end
end

-- scrolling button list nav up EH
Controls['Nav Up'].EventHandler = function(ctl)
    if ctl.Boolean then 
        NavButtons("Up")
        PressAndHoldTimerInitialPress = true
        PressAndHoldTimer:Start(PressAndHoldVal1)
    else
        PressAndHoldTimer:Stop()
        PressAndHoldTimerInitialPress = false
    end
end

-- scrolling button list nav down EH
Controls['Nav Down'].EventHandler = function(ctl)
    if ctl.Boolean then 
        NavButtons("Down")
        PressAndHoldTimerInitialPress = true
        PressAndHoldTimer:Start(PressAndHoldVal1)
    else
        PressAndHoldTimer:Stop()
        PressAndHoldTimerInitialPress = false
    end
end

-- scrolling button list nav left EH
Controls['Nav Left'].EventHandler = function(ctl)
    if ctl.Boolean then 
        NavButtons("Up")
        PressAndHoldTimerInitialPress = true
        PressAndHoldTimer:Start(PressAndHoldVal1)
    else
        PressAndHoldTimer:Stop()
        PressAndHoldTimerInitialPress = false
    end
end

-- scrolling button list nav right EH
Controls['Nav Right'].EventHandler = function(ctl)
    if ctl.Boolean then 
        NavButtons("Down")
        PressAndHoldTimerInitialPress = true
        PressAndHoldTimer:Start(PressAndHoldVal1)
    else
        PressAndHoldTimer:Stop()
        PressAndHoldTimerInitialPress = false
    end
end
-- scrolling button list reset trigger EH
Controls['Reset'].EventHandler = function()
    CurrentPosition = 0
    SetSelected(0)
end

-- scrolling button list selection buttons EH
for i, Ctrl in pairs (Controls["Scrolling Button"]) do
  Ctrl.EventHandler = function()
    -- chooses the right actual button index, instead of the scrolling button index
    SetSelected(CurrentPosition+i)
  end
end

-- scrolling Slider changes EH
Controls['Slider'].EventHandler = function(ctl)
    CurrentPosition = MaxButtons-ctl.Value
    UpdateScrollingButons(1)
end 

-- the main Value input pin has changed
Controls['Selected Value'].EventHandler = function(ctl)
  if(DebugFunction)then print (string.format("Value changed : %s", ctl.String)) end
  s = ctl.String
  for k, v in pairs (ValueTable) do
    if s == v then 
      SetSelected(k)
    end
  end
end

-- the main legend input pin has changed
Controls['Selected Legend'].EventHandler = function(ctl)
  if(DebugFunction)then print (string.format("Legend changed : %s", ctl.String)) end
  s = ctl.String
  for k, v in pairs (LegendTable) do
    if s == v then 
      SetSelected(k)
    end
  end
end

-- the main SelectionComboBox user control has changed
Controls['ComboBox'].EventHandler = function(ctl)
  if(DebugFunction)then print (string.format("SelectionComboBox changed : %s", ctl.String)) end
  s = ctl.String
  for k, v in ipairs (LegendTable) do
    if s == v then
      SetSelected(k)
    end
  end
end

-- PressAndHoldTimer expires
PressAndHoldTimer.EventHandler = function()

    -- upon first entry of this EVT, start a new timer with a faster value
    if PressAndHoldTimerInitialPress == true then  
        PressAndHoldTimerInitialPress = false
        PressAndHoldTimer:Stop()
        PressAndHoldTimer:Start(PressAndHoldVal2)
    end

    if Controls['Nav Up'].Boolean or Controls['Nav Left'].Boolean then 
      NavButtons("Up")
    elseif Controls['Nav Down'].Boolean or Controls['Nav Right'].Boolean  then 
      NavButtons("Down")
    else 
      PressAndHoldTimer:Stop()
    end
end


--[[ ************ On Start ************ ]]--

if Controls then
  -- print general info
  print("=== Starting "..PluginInfo.Name.." V"..PluginInfo.Version.." ===")

  -- print if system is live or emulating
  if e then
    print("System Is Emulating")
  else
    print("System Is Live With Core")
  end

  -- setup debug
  SetupDebugPrint()

  -- updated the LegendTable
  UpdateLegendTable()

  -- updated the ValueTable
  UpdateValueTable()

  -- updated the SelectionComboBox.Choices with the LegendTable
  Controls['ComboBox'].Choices = LegendTable

  -- assign generic button legends and values if no user input has occurred
  if Controls['User Input Flag'].Boolean == false then 
    print("Starting Fresh")
    for i,v in pairs (Controls['Legend']) do 
        v.String = "Button "..i
    end
    
    for i,v in pairs (Controls['Value']) do 
        v.String = i
    end

    UpdateLegendTable()
    UpdateValueTable()
  else
    print("Using Previously Entered Legends and Values")

  end
 
end