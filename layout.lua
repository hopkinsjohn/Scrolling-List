local CurrentPage = PageNames[props["page_index"].Value]

------------------ local variables
local TotalButtonCount = props["List Buttons"].Value -- this reads the property "Number of Buttons" and we use this below to layout the desired buttons
local ScrollingButtonCount = props["Scrolling Buttons"].Value -- this reads the property "Visible Buttons" and we use this below to layout the desired buttons
local Orientation = props["Orientation"].Value

local ButtonPrimaryOffColor = {235,245,252}
local ButtonPrimaryOnColor = {5, 97, 165}
local ButtonStrokeColor = {5, 97, 165}
local TextPrimaryColor = {51,51,51}
local GroupBoxFillColor =  {235,245,252}
local GroupBoxStrokeColor = {5, 97, 165}
local TextFont = "OpenSans"
local TextFontStyle = "Light"


------------------ page 1
if CurrentPage == "Scrolling" then
  
  ----------------- scrolling page graphics
  if Orientation == "Vertical" then
      -- groupbox background
      table.insert(graphics,{
        Type = "GroupBox",
        Text = "Scrolling List",
        HTextAlign = "Center",
        Fill = GroupBoxFillColor,
        StrokeWidth = 1,
        StrokeColor = GroupBoxStrokeColor,
        CornerRadius = 5,
        Position = {2,2},
        Size = {210,ScrollingButtonCount*20+165},
        ZOrder = -1,
        Font = TextFont,
        FontStyle = TextFontStyle,
      })
      -- output selection header
      table.insert(graphics,{
        Type = "Header",
        Text = "Selection",
        Position = {41,ScrollingButtonCount*20+75},
        Size = {135,15},
        FontSize = 12,
        Font = TextFont,
        FontStyle = TextFontStyle,
        TextColor = TextPrimaryColor,
        HTextAlign = "Center",
      })  
      -- output selection label : Legend
      table.insert(graphics,{
        Type = "Label",
        Text = "Legend",
        Position = {9,ScrollingButtonCount*20+110},
        Size = {65,20},
        FontSize = 10,
        Font = TextFont,
        FontStyle = TextFontStyle,
        TextColor = TextPrimaryColor,
        HTextAlign = "Center",
        Margin = 1,
      })  
      -- output selection label : Value
      table.insert(graphics,{
        Type = "Label",
        Text = "Value",
        Position = {74,ScrollingButtonCount*20+110},
        Size = {65,20},
        FontSize = 10,
        Font = TextFont,
        FontStyle = TextFontStyle,
        TextColor = TextPrimaryColor,
        HTextAlign = "Center",
        Margin = 1,
      }) 
      -- output selection label : ComboBox
      table.insert(graphics,{
        Type = "Label",
        Text = "ComboBox",
        Position = {139,ScrollingButtonCount*20+110},
        Size = {65,20},
        FontSize = 10,
        Font = TextFont,
        FontStyle = TextFontStyle,
        TextColor = TextPrimaryColor,
        HTextAlign = "Center",
        Margin = 1,
      })
      -- output selection Control : Legend
      layout["Selected Legend"] = { 
        PrettyName = "Selected~Legend",
        Style = "Text",
        Position = {9,ScrollingButtonCount*20+130},
        Size = {65,20},
        Color = {255,255,255},
        FontSize = 8,
        Margin = 1,
        HTextAlign = "Center",
        IsReadOnly = false,
      }
      -- output selection Control : Value
      layout["Selected Value"] = {
        PrettyName = "Selected~Value", 
        Style = "Text",
        Position = {74,ScrollingButtonCount*20+130},
        Size = {65,20},
        Color = {255,255,255},
        FontSize = 8,
        Margin = 1,
        HTextAlign = "Center",
        IsReadOnly = false,
      }
      -- output selection Control : Selection
      layout["ComboBox"] = {
        PrettyName = "Selection",
        Style = "ComboBox",
        Position = {139,ScrollingButtonCount*20+130},
        Size = {65,20},
        Color = {255,255,255},
        FontSize = 8,
        Margin = 1,
        HTextAlign = "Center",
        IsReadOnly = false,
      }
      -- reset list & selection
      layout['Reset'] = {           
        Style = "Button",
        PrettyName = ("Scrolling List~Reset"),
        ButtonStyle = "Trigger",
        ButtonVisualStyle = "Gloss",
        WordWrap = true,
        Position = {9,ScrollingButtonCount*20+72},
        Size = {20,20},
        Color = ButtonPrimaryOnColor,
        UnlinkOffColor = true ,
        OffColor = ButtonPrimaryOffColor,
        StrokeColor = ButtonStrokeColor,
        Margin = 1,
        IsReadOnly = false,
        IconColor = ButtonPrimaryOnColor,
      }
      -- Selected Legend Display
      layout["Selected Legend Display"] = {           
        Style = "Text",
        PrettyName = "Selection Display",
        TextBoxStyle = "NoBackground",
        Font = TextFont,
        TextColor = ButtonStrokeColor,
        FontStyle = TextFontStyle,
        HTextAlign = "Center",
        WordWrap = false,
        Position = {41,ScrollingButtonCount*20+90},
        Size = {135,20},
        FontSize = 12,
        IsReadOnly = true,
        Margin = 1,
      }
      -- scrolling list nav up
      layout['Nav Up'] = {           
        Style = "Button",
        PrettyName = ("Scrolling List~Nav Up"),
        ButtonStyle = "Momentary",
        ButtonVisualStyle = "Gloss",
        WordWrap = true,
        Position = {168,50},
        Size = {20,20},
        Color = ButtonPrimaryOnColor,
        UnlinkOffColor = true ,
        OffColor = ButtonPrimaryOffColor,
        StrokeColor = ButtonStrokeColor,
        Margin = 1,
        IsReadOnly = false,
        IconColor = ButtonPrimaryOnColor,
      }
      -- scrolling list nav down
      layout['Nav Down'] = {         
        Style = "Button",
        PrettyName = ("Scrolling List~Nav Down"),
        ButtonStyle = "Momentary",
        ButtonVisualStyle = "Gloss",
        WordWrap = true,
        Position = {168,50+(ScrollingButtonCount*20)-20},
        Size = {20,20},
        Color =ButtonPrimaryOnColor,
        UnlinkOffColor = true ,
        OffColor = ButtonPrimaryOffColor,
        StrokeColor = ButtonStrokeColor,
        Margin = 1,
        IsReadOnly = false,
        IconColor = ButtonPrimaryOnColor,
      }
      -- scrolling list slider
      layout['Slider'] = {           
        Style = "Fader",
        PrettyName = ("Scrolling List~Slider"),
        Position = {145,50},
        Size = {22,ScrollingButtonCount*20},
        Color = ButtonPrimaryOnColor,
        Margin = 1,
        IsReadOnly = false,
      }
      
      ---- for loop to interate laying out the controls on the page
      for i=1, ScrollingButtonCount do   
        
        -- Dynamic text indicators that identify where the button is on the list
        layout["Scrolling Button Int "..i] = {           
          Style = "Text",
          PrettyName = string.format("Scrolling Button~%i~Number", i),
          TextBoxStyle = "NoBackground",
          Font = TextFont,
          FontStyle = TextFontStyle,
          HTextAlign = "Right",
          WordWrap = false,
          Position = {50,i*20+30},
          Size = {25,20},
          FontSize = 12,
          IsReadOnly = true,
          Margin = 1,
        }

        -- Scrolling Selection Buttons
        layout["Scrolling Button "..i] = {           
          Style = "Button",
          PrettyName = string.format("Scrolling List~Button %i~Select", i),
          ButtonStyle = "Toggle",
          ButtonVisualStyle = "Gloss",
          WordWrap = true,
          Position = {75,i*20+30},
          Size = {65,20},
          Color = ButtonPrimaryOnColor,
          UnlinkOffColor = true ,
          OffColor = ButtonPrimaryOffColor,
          StrokeColor = ButtonStrokeColor,
          Margin = 1,
          IsReadOnly = false,
        }

        -- Selector Selection Triggers - Not shown on layout but has to be defined to expose the control pins (PrettyName)
        layout["Scrolling Trigger "..i] = {           
          PrettyName = string.format("Scrolling List~Button %i~Trigger", i),
          IsReadOnly = false,
          Style = "None", -- "None" will prevent controls from showing on the page.
        }
      end
  
  elseif Orientation == "Horizontal" then

    local GroupBoxHorSize = ScrollingButtonCount*65+126

    -- groupbox background
    table.insert(graphics,{
      Type = "GroupBox", 
      Text = "Scrolling List",
      HTextAlign = "Center",
      Fill = GroupBoxFillColor,
      StrokeWidth = 1,
      StrokeColor = GroupBoxStrokeColor,
      CornerRadius = 5,
      Position = {2,2},
      Size = {GroupBoxHorSize,215},
      ZOrder = -1,
      Font = TextFont,
      FontStyle = TextFontStyle,
    })
    -- output selection header
    table.insert(graphics,{
      Type = "Header",
      Text = "Selection",
      Position = {GroupBoxHorSize/2-68,120},
      Size = {135,15},
      FontSize = 12,
      Font = TextFont,
      FontStyle = TextFontStyle,
      TextColor = TextPrimaryColor,
      HTextAlign = "Center",
    })  
    -- output selection label : Legend
    table.insert(graphics,{
      Type = "Label",
      Text = "Legend",
      Position = {GroupBoxHorSize/2-98,155},
      Size = {65,20},
      FontSize = 10,
      Font = TextFont,
      FontStyle = TextFontStyle,
      TextColor = TextPrimaryColor,
      HTextAlign = "Center",
      Margin = 1,
    })  
    -- output selection label : Value
    table.insert(graphics,{
      Type = "Label",
      Text = "Value",
      Position = {GroupBoxHorSize/2-33,155},
      Size = {65,20},
      FontSize = 10,
      Font = TextFont,
      FontStyle = TextFontStyle,
      TextColor = TextPrimaryColor,
      HTextAlign = "Center",
      Margin = 1,
    }) 
    -- output selection label : ComboBox
    table.insert(graphics,{
      Type = "Label",
      Text = "ComboBox",
      Position = {GroupBoxHorSize/2+32,155},
      Size = {65,20},
      FontSize = 10,
      Font = TextFont,
      FontStyle = TextFontStyle,
      TextColor = TextPrimaryColor,
      HTextAlign = "Center",
      Margin = 1,
    })
    -- output selection Control : Legend
    layout["Selected Legend"] = { 
      PrettyName = "Select~Legend",
      Style = "Text",
      Position = {GroupBoxHorSize/2-98,175},
      Size = {65,20},
      Color = {255,255,255},
      FontSize = 8,
      Margin = 1,
      HTextAlign = "Center",
      IsReadOnly = false,
    }
    -- output selection Control : Value
    layout["Selected Value"] = {
      PrettyName = "Select~Value", 
      Style = "Text",
      Position = {GroupBoxHorSize/2-33,175},
      Size = {65,20},
      Color = {255,255,255},
      FontSize = 8,
      Margin = 1,
      HTextAlign = "Center",
      IsReadOnly = false,
    }
    -- output selection Control : Selection
    layout["ComboBox"] = {
      PrettyName = "Selection",
      Style = "ComboBox",
      Position = {GroupBoxHorSize/2+32,175},
      Size = {65,20},
      Color = {255,255,255},
      FontSize = 8,
      Margin = 1,
      HTextAlign = "Center",
      IsReadOnly = false,
    }
    -- reset list & selection
    layout['Reset'] = {           
      Style = "Button",
      PrettyName = ("Scrolling List~Reset"),
      ButtonStyle = "Trigger",
      ButtonVisualStyle = "Gloss",
      WordWrap = true,
      Position = {GroupBoxHorSize/2-98,118},
      Size = {20,20},
      Color = ButtonPrimaryOnColor,
      UnlinkOffColor = true ,
      OffColor = ButtonPrimaryOffColor,
      StrokeColor = ButtonStrokeColor,
      Margin = 1,
      IsReadOnly = false,
      IconColor = ButtonPrimaryOnColor,
    }
    -- Selected Legend Display
    layout["Selected Legend Display"] = {           
      Style = "Text",
      PrettyName = "Selection Display",
      TextBoxStyle = "NoBackground",
      Font = TextFont,
      TextColor = ButtonStrokeColor,
      FontStyle = TextFontStyle,
      HTextAlign = "Center",
      WordWrap = false,
      Position = {GroupBoxHorSize/2-68,135},
      Size = {135,20},
      FontSize = 12,
      IsReadOnly = true,
      Margin = 1,
    }

    -- scrolling list nav left
    layout['Nav Left'] = {           
      Style = "Button",
      PrettyName = ("Scrolling List~Nav Left"),
      ButtonStyle = "Momentary",
      ButtonVisualStyle = "Gloss",
      WordWrap = true,
      Position = {45,90},
      Size = {20,20},
      Color = ButtonPrimaryOnColor,
      UnlinkOffColor = true ,
      OffColor = ButtonPrimaryOffColor,
      StrokeColor = ButtonStrokeColor,
      Margin = 1,
      IsReadOnly = false,
      IconColor = ButtonPrimaryOnColor,
    }
    -- scrolling list nav down
    layout['Nav Right'] = {         
      Style = "Button",
      PrettyName = ("Scrolling List~Nav Right"),
      ButtonStyle = "Momentary",
      ButtonVisualStyle = "Gloss",
      WordWrap = true,
      Position = {65+(ScrollingButtonCount*65),90},
      Size = {20,20},
      Color =ButtonPrimaryOnColor,
      UnlinkOffColor = true ,
      OffColor = ButtonPrimaryOffColor,
      StrokeColor = ButtonStrokeColor,
      Margin = 1,
      IsReadOnly = false,
      IconColor = ButtonPrimaryOnColor,
    }
    -- scrolling list slider
    layout['Slider'] = {           
      Style = "Fader",
      PrettyName = ("Scrolling List~Slider"),
      Position = {65,90},
      Size = {ScrollingButtonCount*65,20},
      Color = ButtonPrimaryOnColor,
      Margin = 1,
      IsReadOnly = false,
    }

    ---- for loop to interate laying out the controls on the page
    for i=1, ScrollingButtonCount do  
      
      local ScrollingButtonHorPos = i*65
      
      -- Dynamic text indicators that identify where the button is on the list
      layout["Scrolling Button Int "..i] = {           
        Style = "Text",
        PrettyName = string.format("Scrolling List~Button %i~Number", i),
        TextBoxStyle = "NoBackground",
        Font = TextFont,
        FontStyle = TextFontStyle,
        HTextAlign = "Right",
        WordWrap = false,
        Position = {ScrollingButtonHorPos,45},
        Size = {65,20},
        FontSize = 12,
        HTextAlign = "Center",
        IsReadOnly = true,
        Margin = 1,
      }

      -- Scrolling Selection Buttons
      layout["Scrolling Button "..i] = {           
        Style = "Button",
        PrettyName = string.format("Scrolling List~Button %i~Select", i),
        ButtonStyle = "Toggle",
        ButtonVisualStyle = "Gloss",
        WordWrap = true,
        Position = {ScrollingButtonHorPos,65},
        Size = {65,20},
        Color = ButtonPrimaryOnColor,
        UnlinkOffColor = true ,
        OffColor = ButtonPrimaryOffColor,
        StrokeColor = ButtonStrokeColor,
        Margin = 1,
        IsReadOnly = false,
      }

      -- Selector Selection Triggers - Not shown on layout but has to be defined to expose the control pins (PrettyName)
      layout["Scrolling Trigger "..i] = {           
        PrettyName = string.format("Scrolling List~Button %i~Trigger", i),
        IsReadOnly = false,
        Style = "None", -- "None" will prevent controls from showing on the page.
      }
    end


  end




------------------ page 2 layout
elseif CurrentPage == "List" then


  ----------------- List page graphics
  -- groupbox background
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "List Properties",
    HTextAlign = "Center",
    Fill = GroupBoxFillColor,
    StrokeWidth = 1,
    StrokeColor = GroupBoxStrokeColor,
    CornerRadius = 5,
    Position = {2,2},
    Size = {260,TotalButtonCount*20+55},
    ZOrder = -1,
    Font = TextFont,
    FontStyle = TextFontStyle,
  })
  table.insert(graphics,{
    Type = "Label",
    Text = "Select",
    Position = {35,25},
    Size = {65,15},
    FontSize = 12,
    Font = TextFont,
    FontStyle = TextFontStyle,
    TextColor = TextPrimaryColor,
    HTextAlign = "Center",
  })  
  table.insert(graphics,{
    Type = "Label",
    Text = "Legend",
    Position = {105,25},
    Size = {65,15},
    FontSize = 12,
    Font = TextFont,
    FontStyle = TextFontStyle,
    TextColor = TextPrimaryColor,
    HTextAlign = "Center",
  })  
  table.insert(graphics,{
    Type = "Label",
    Text = "Value",
    Position = {175,25},
    Size = {50,15},
    FontSize = 12,
    Font = TextFont,
    FontStyle = TextFontStyle,
    TextColor = TextPrimaryColor,
    HTextAlign = "Center",
  }) 


  
  
  

  ----------------- List page controls
  
  ---- for loop to interate laying out the controls on the page
  
  for i=1, TotalButtonCount do  
    -- static text boxes telling you what number control
    table.insert(graphics,{
      Type = "Text",
      Text = string.format("%i",i),
      Position = {10,i*20+21},
      Size = {25,20},
      FontSize = 12,
      HTextAlign = "Right",
      Font = TextFont,
      FontStyle = TextFontStyle,
    })

    -- Selector Buttons
    layout["Button "..i] = {           
      Style = "Button",
      PrettyName = string.format("Main List~Button %i~Select", i),
      ButtonStyle = "Toggle",
      ButtonVisualStyle = "Gloss",
      WordWrap = true,
      Position = {35,i*20+21},
      Size = {65,20},
      Color = ButtonPrimaryOnColor,
      UnlinkOffColor = true ,
      OffColor = ButtonPrimaryOffColor,
      StrokeColor = ButtonStrokeColor,
      Margin = 1,
      IsReadOnly = false,
      Font = TextFont,
      FontStyle = TextFontStyle,
    }
    -- Selector Button Legends
    layout["Legend "..i] = {           
      Style = "Text",
      PrettyName = string.format("Main List~Button %i~Legend", i),
      TextBoxStyle = "Normal",
      HTextAlign = "Left",
      WordWrap = true,
      Position = {105,i*20+21},
      Size = {65,20},
      Color = { 255,255,255},
      Margin = 1,
      Padding = 2,
      IsReadOnly = false,
    }
    -- Selector Button Value
    layout["Value "..i] = {           
      Style = "Text",
      PrettyName = string.format("Main List~Button %i~Value", i),
      TextBoxStyle = "Normal",
      HTextAlign = "Left",
      WordWrap = true,
      Position = {175,i*20+21},
      Size = {50,20},
      Color = { 255,255,255},
      Margin = 1,
      Padding = 2,
      IsReadOnly = false,
    }
    -- Selector Buttons - Not shown on layout but has to be defined to expose the control pins (PrettyName)
    layout["Trigger "..i] = {           
      PrettyName = string.format("Main List~Button %i~Trigger", i),
      IsReadOnly = false,
      Style = "None", -- "None" will prevent controls from showing on the page.
    }
  end


end
