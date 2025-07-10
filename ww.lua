-- تحميل مكتبة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- إنشاء النافذة
local Window = Rayfield:CreateWindow({
	Name = "Galaxy", 
	LoadingTitle = "تشغيل الواجهة...",
	LoadingSubtitle = "by Galaxy", 
	ConfigurationSaving = {
		Enabled = false,
	},
	Discord = {
		Enabled = false,
	},
	KeySystem = false,
})

-- إنشاء تبويب
local MainTab = Window:CreateTab("الرئيسية", 4483362458)

-- إنشاء قسم
local Section = MainTab:CreateSection("تشغيل السكربت")

-- زر تنفيذ السكربت
MainTab:CreateButton({
	Name = "🚀 تشغيل السكربت الخارجي",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/Final.lua"))()
	end,
})
