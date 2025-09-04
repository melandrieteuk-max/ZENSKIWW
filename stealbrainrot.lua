-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ███████╗████████╗███████╗ █████╗ ██╗     
-- ██╔════╝╚══██╔══╝██╔════╝██╔══██╗██║     
-- ███████╗   ██║   █████╗  ███████║██║     
-- ╚════██║   ██║   ██╔══╝  ██╔══██║██║     
-- ███████║   ██║   ███████╗██║  ██║███████╗
-- ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝
-- 🚀 ZENSKIWW Hub - Steal Brainrot 🚀
-- Loader UI by kamu :)

-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Buat Window
local Window = OrionLib:MakeWindow({
    Name = "ZENSKIWW Hub | Steal Brainrot",
    HidePremium = false,
    SaveConfig = false
})

-- Variabel Global
getgenv().AutoBuy = false
getgenv().ESPBrainrot = false
getgenv().MinValue = 10000

-- Tab Utama
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Dropdown pilih min value
MainTab:AddDropdown({
    Name = "Minimal Money /s",
    Default = "10k/s",
    Options = {"10k/s", "50k/s", "100k/s"},
    Callback = function(Value)
        if Value == "10k/s" then
            getgenv().MinValue = 10000
        elseif Value == "50k/s" then
            getgenv().MinValue = 50000
        elseif Value == "100k/s" then
            getgenv().MinValue = 100000
        end
        OrionLib:MakeNotification({
            Name = "ZENSKIWW Hub",
            Content = "✅ MinValue di-set ke "..Value,
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

-- Toggle Auto Buy
MainTab:AddToggle({
    Name = "Auto Buy Brainrot",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBuy = Value
        task.spawn(function()
            while getgenv().AutoBuy do
                local player = game.Players.LocalPlayer
                if player and player:FindFirstChild("leaderstats") and player.leaderstats.Cash.Value >= getgenv().MinValue then
                    -- Ganti RemoteEvent & item sesuai game
                    game.ReplicatedStorage:WaitForChild("RemoteEventBuy"):FireServer("Brainrot")
                    print("[AutoBuy] Brainrot dibeli.")
                end
                task.wait(2)
            end
        end)
    end
})

-- Toggle ESP Brainrot
MainTab:AddToggle({
    Name = "ESP Brainrot",
    Default = false,
    Callback = function(Value)
        getgenv().ESPBrainrot = Value
        if Value then
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name == "Brainrot" then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = obj
                end
            end
            workspace.ChildAdded:Connect(function(obj)
                if obj.Name == "Brainrot" and getgenv().ESPBrainrot then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = obj
                end
            end)
            print("👀 ESP Brainrot Aktif")
        else
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "ESP_Highlight" then
                    obj:Destroy()
                end
            end
            print("❌ ESP Brainrot Nonaktif")
        end
    end
})

OrionLib:Init()
