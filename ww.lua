-- Load Rayfield library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create the key system window
local Window = Rayfield:CreateWindow({
    Name = "Galaxy",
    LoadingTitle = "Loading Galaxy...",
    LoadingSubtitle = "Secure Access Required",
    ConfigurationSaving = {
        Enabled = false,
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = true,
    KeySettings = {
        Title = "Enter Access Key",
        Subtitle = "Type the key to unlock",
        Note = "If you don't have the key, join our Discord server.",
        FileName = "GalaxyKey",
        SaveKey = false,
        Key = "Gax",
        GiveKeyUrl = "https://discord.gg/yqcD2DwHbg"
    }
})

-- زر لنسخ رابط الديسكورد إذا ما عنده المفتاح
Rayfield:Notify({
    Title = "Need Key?",
    Content = "Click the button below to copy the Discord link.",
    Duration = 6.5,
    Actions = {
        Ignore = {
            Name = "Copy Link",
            Callback = function()
                setclipboard("https://discord.gg/yqcD2DwHbg")
                Rayfield:Notify({
                    Title = "Copied!",
                    Content = "Discord invite link copied to your clipboard.",
                    Duration = 4
                })
            end
        }
    }
})

-- Create main tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Create section in main tab
local Section = MainTab:CreateSection("Script Execution")

-- Add button to execute external script
MainTab:CreateButton({
    Name = "Steal Map | Made By Azc - Key Azc",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/Final.lua"))()
    end,
})
