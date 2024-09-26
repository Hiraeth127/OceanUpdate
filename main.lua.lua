local function rename(remotename, hashedremote)
    hashedremote.Name = remotename
end

-- Apply renaming to upvalues of the RouterClient.init function
table.foreach(getupvalue(require(game:GetService("ReplicatedStorage"):WaitForChild("Fsys")).load("RouterClient").init, 4), rename)

_G.autoPayBool = false
_G.autoRunBool = false
_G.petFarmRun = false
_G.cpuLimiter = false
_G.autoSave = false
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local resetCode = "OceanAPI/AttemptPurchaseDive"


-- Auto Pay
local function autoPay()
    print("Function: autoPay")
    -- Invoke the server-side function
    local api = ReplicatedStorage:WaitForChild("API")
    local functionToCall = api:FindFirstChild(resetCode)
    if functionToCall and functionToCall:IsA("RemoteFunction") then
        functionToCall:InvokeServer()
    else
        warn("API function not found or is not a RemoteFunction")
    end
end
-- Function to prevent AFK
local function preventAFK()
    print("Function: preventAFK")
    local virtualUser = game:GetService("VirtualUser")

    player.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end)
end
-- Prevent AFK
preventAFK()

-- Function to rename remote instances
local function rename(remotename, hashedremote)
    hashedremote.Name = remotename
end

-- Apply renaming to upvalues of the RouterClient.init function
table.foreach(getupvalue(require(game:GetService("ReplicatedStorage"):WaitForChild("Fsys")).load("RouterClient").init, 4), rename)

getgenv().fsys = require(game.ReplicatedStorage:WaitForChild("Fsys")).load


local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🔥 Hira | X 🔫",
   LoadingTitle = "🔫 Hira X 💥",
   LoadingSubtitle = "by Hiraeth",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = HiraXFiles, -- Create a custom folder for your hub/game
      FileName = "Example Hub"
   },
   Discord = {
      Enabled = true,
      Invite = "mSM7UgCc", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Discord",
      Subtitle = "https://discord.gg/mSM7UgCc",
      Note = "Key In Discord https://discord.gg/mSM7UgCc",
      FileName = "Hiraeth3011KeySSystemm", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/dZPbFssu"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("🏠 Home", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

local Toggle = MainTab:CreateToggle({
    Name = "Cpu Limiter",
    CurrentValue = false,
    Flag = "CpuLimiter", -- Change the flag
    Callback = function(Value)
        cpuLimiter = Value
        if cpuLimiter then
            setfpscap(10)
        else
            setfpscap(60)
        end
            
    end,
})

local Slider = MainTab:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderws", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "JumpPower Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "sliderjp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})

local Input = MainTab:CreateInput({
   Name = "Walkspeed",
   PlaceholderText = "1-500",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Text)
   end,
})

local OtherSection = MainTab:CreateSection("Other")

local PetToggle = MainTab:CreateToggle({
    Name = "Auto PET & BABY Farm",
    CurrentValue = false,
    Flag = "ToggleAutoFarmPet", -- Change the flag
    Callback = function(Value)
        _G.autoPetBabyRun = Value
        if not _G.autoRunBool then
            if _G.autoPetBabyRun then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Hiraeth127/PetesFarm/refs/heads/main/PetesFarm.lua"))()
            else 
                getgenv().MasterFarm = false
            end
        else
            Rayfield:Notify({
                Title = "❗WARNING❗",
                Content = "Do not turn on OceanFarm and Pet/Baby Farm at the same time.",
                Duration = 5,
                Image = 13047715178,
                Actions = { -- Notification Buttons
                   Ignore = {
                      Name = "Okay!",
                      Callback = function()
                      print("The user tapped Okay!")
                   end
                },
             },
             })
            Toggle:Set(false)
        end
    end,
})

local OceanToggle = MainTab:CreateToggle({
    Name = "Auto Ocean Farm",
    CurrentValue = false,
    Flag = "ToggleAutoFarmOcean", -- Change the flag
    Callback = function(Value)
        _G.autoRunBool = Value
        if not _G.autoPetBabyRun then
            if _G.autoRunBool then
                _G.autoRunBool = true
                loadstring(game:HttpGet('https://raw.githubusercontent.com/Hiraeth127/OceanFarm/refs/heads/main/Main_Ocean.lua'))()
            end
        else
            Rayfield:Notify({
                Title = "❗WARNING❗",
                Content = "Do not turn on OceanFarm and Pet/Baby Farm at the same time.",
                Duration = 5,
                Image = 13047715178,
                Actions = { -- Notification Buttons
                   Ignore = {
                      Name = "Okay!",
                      Callback = function()
                      print("The user tapped Okay!")
                   end
                },
             },
             })
            Toggle:Set(false)
        end
    end,
})

Rayfield:Notify({
    Title = "Welcome To Hira X",
    Content = "meh idk",
    Duration = 5,
    Image = 13047715178,
    Actions = { -- Notification Buttons
       Ignore = {
          Name = "Cool!",
          Callback = function()
          print("The user tapped Okay!")
       end
    },
 },
 })

local Toggle = MainTab:CreateToggle({
    Name = "Auto Pay Tim | 1k Bucks",
    CurrentValue = false,
    Flag = "ToggleAutoPay", -- Change the flag
    Callback = function(Value)
        autoPayBool = Value
        if autoPayBool then
            autoPay() -- Start the auto-pay function if enabled
        end
    end,
})

local Button = MainTab:CreateButton({
    Name = "Buy Big Wish",
    Callback = function()
        local args = {
            [1] = "ocean_2024_big_wish"
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("LootBoxAPI/ExchangeItemForReward"):InvokeServer(unpack(args))
    end,
})

local Button = MainTab:CreateButton({
    Name = "Buy Small Wish",
    Callback = function()
        local args = {
            [1] = "ocean_2024_small_wish"
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("LootBoxAPI/ExchangeItemForReward"):InvokeServer(unpack(args))
    end,
})

local Button = MainTab:CreateButton({
    Name = "Auto Save and Load Settings",
    Callback = function()
        Rayfield:LoadConfiguration()
    end,
})