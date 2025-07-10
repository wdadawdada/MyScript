-- Load Rayfield library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create the key system window
local Window = Rayfield:CreateWindow({
    Name = "Galaxy ",
    LoadingTitle = "Loading Galaxy...",
    LoadingSubtitle = "Secure Access Required",
    ConfigurationSaving = {
        Enabled = false,
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = true,  -- Enable key system
    KeySettings = {
        Title = "Enter Access Key",
        Subtitle = "Type the key to unlock",
        Note = "Contact  if you don't have a key",
        FileName = "GalaxyKey",
        SaveKey = false,
        Key = "Gax",
        GiveKeyUrl = "https://discord.gg/yqcD2DwHbg",  -- Optional URL if you want
    }
})

-- Create main tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Create section in main tab
local Section = MainTab:CreateSection("Script Execution")

-- Add button to execute external script
MainTab:CreateButton({
    Name = "Steal Map Script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/Final.lua"))()
    end,
})
