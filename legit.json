task.wait(3)

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local FakeUserName = "gg/rWQZv7zjxm"
local FakeDisplayName = "gg/rWQZv7zjxm"
local COPY_USER_ID = 0

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
                    bc.HeadColor3 = obj.HeadColor3
                    bc.LeftArmColor3 = obj.LeftArmColor3
                    bc.RightArmColor3 = obj.RightArmColor3
                    bc.LeftLegColor3 = obj.LeftLegColor3
                    bc.RightLegColor3 = obj.RightLegColor3
                    bc.TorsoColor3 = obj.TorsoColor3 
                end
            end
        end
    else
        local bc = char:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors", char)
        local black = Color3.new(0, 0, 0)
        bc.HeadColor3 = black
        bc.LeftArmColor3 = black
        bc.RightArmColor3 = black
        bc.LeftLegColor3 = black
        bc.RightLegColor3 = black
        bc.TorsoColor3 = black
        
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
                t = t:gsub(pl.Name, FakeUserName)
                     :gsub(pl.DisplayName, FakeDisplayName)
            end
            
            if originalText ~= t then obj.Text = t end
        end
        check()
        obj:GetPropertyChangedSignal("Text"):Connect(check)
    end
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

for _, v in ipairs(LP.PlayerGui:GetDescendants()) do applyFilters(v) end
LP.PlayerGui.DescendantAdded:Connect(applyFilters)

for _, v in ipairs(workspace:GetDescendants()) do applyFilters(v) end
workspace.DescendantAdded:Connect(applyFilters)

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
