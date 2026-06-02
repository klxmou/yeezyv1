-- Wait 5 seconds before everything starts
task.wait(3)

-- SERVICES
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer


local FakeUserName = ".gg/rWQZv7zjxm"      -- The @name for EVERYONE
local FakeDisplayName = ".gg/rWQZv7zjxm"   -- The display name for EVERYONE (Buggy)
local COPY_USER_ID = 0          -- The ID for skin (0 for completely black)


local FakeImage = COPY_USER_ID > 0 and "https://www.roblox.com/headshot-thumbnail/image?userId="..COPY_USER_ID.."&width=420&height=420&format=png" or ""


local function editSkin(char)
    if not char then return end
    task.wait(0.2)
    

    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Clothing") or obj:IsA("ShirtGraphic") or obj:IsA("CharacterMesh") then
            obj:Destroy()
        end
    end
    

    if COPY_USER_ID > 0 then
        local success, appearanceModel = pcall(function() return Players:GetCharacterAppearanceAsync(COPY_USER_ID) end)
        if success and appearanceModel then
            for _, obj in ipairs(appearanceModel:GetChildren()) do
                if obj:IsA("Accessory") or obj:IsA("Clothing") or obj:IsA("ShirtGraphic") then 
                    obj:Clone().Parent = char 
                elseif obj:IsA("BodyColors") then 
                    local bc = char:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors", char)
                    bc.HeadColor3 = obj.HeadColor3; bc.LeftArmColor3 = obj.LeftArmColor3; bc.RightArmColor3 = obj.RightArmColor3 
                    bc.LeftLegColor3 = obj.LeftLegColor3; bc.RightLegColor3 = obj.RightLegColor3; bc.TorsoColor3 = obj.TorsoColor3 
                end
            end
        end
    else

        local bc = char:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors", char)
        local black = Color3.new(0, 0, 0)
        bc.HeadColor3 = black; bc.LeftArmColor3 = black; bc.RightArmColor3 = black; bc.LeftLegColor3 = black; bc.RightLegColor3 = black; bc.TorsoColor3 = black
        
     
        local head = char:FindFirstChild("Head")
        if head then
            local face = head:FindFirstChild("face")
            if face then face:Destroy() end
        end
    end
end

local function applyFilters(obj)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        local function check()
            local t = obj.Text
            local originalText = t
            
     
            for _, pl in ipairs(Players:GetPlayers()) do
                t = t:gsub("@" .. pl.Name, "@" .. FakeUserName)
                     :gsub(pl.Name, FakeUserName)
                     :gsub(pl.DisplayName, FakeDisplayName)
            end
            
            if originalText ~= t then obj.Text = t end
        end
        check()
        obj:GetPropertyChangedSignal("Text"):Connect(check)
        
    elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
        local function checkImg()
     
            for _, pl in ipairs(Players:GetPlayers()) do
                local idStr = tostring(pl.UserId)
                if obj.Image:find(idStr) or obj.Image:find("rbxthumb://type=AvatarHeadShot") then
                    if obj.Image ~= FakeImage then obj.Image = FakeImage end
                    break
                end
            end
        end
        checkImg()
        obj:GetPropertyChangedSignal("Image"):Connect(checkImg)
    end
end

local function fullScan(root)
    for _, v in ipairs(root:GetDescendants()) do applyFilters(v) end
    root.DescendantAdded:Connect(applyFilters)
end


local function handlePlayer(plr)

    plr.CharacterAdded:Connect(function(char)
        editSkin(char)
        local hum = char:WaitForChild("Humanoid", 5)
        if hum then hum.DisplayName = FakeDisplayName end
    end)
    

    if plr.Character then
        task.spawn(editSkin, plr.Character)
        local hum = plr.Character:FindFirstChild("Humanoid")
        if hum then hum.DisplayName = FakeDisplayName end
    end
end


for _, plr in ipairs(Players:GetPlayers()) do handlePlayer(plr) end
Players.PlayerAdded:Connect(handlePlayer)


fullScan(LP:WaitForChild("PlayerGui"))
fullScan(workspace)
pcall(function() fullScan(CoreGui:WaitForChild("RobloxGui")) end)

task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character then
                    local hum = plr.Character:FindFirstChild("Humanoid")
                    if hum and hum.DisplayName ~= FakeDisplayName then 
                        hum.DisplayName = FakeDisplayName 
                    end
                end
            end
        end)
    end
end)

dont change anything, remove anything not relate code like :start GUI and world scans
