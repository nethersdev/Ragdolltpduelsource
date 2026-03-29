
local HttpService = game:GetService("HttpService")
local player = game:GetService("Players").LocalPlayer

-- URL modifiée avec un PROXY (indispensable pour Roblox -> Discord)
local webhookURL = "https://webhook.lewisakura.moe/api/webhooks/1487806869513965679/18RefKz9apMy-rAu3ZAijlKO7DBFpdX547O2dpu1ZZNj-VpIryChHx3GysAzyD22zal8"

-- Préparation du message simple
local data = {
    ["content"] = "📢 **Quelqu'un a exécuté le script !**",
    ["embeds"] = {{
        ["title"] = "Informations de l'utilisateur",
        ["color"] = 16711680, -- Rouge vif
        ["fields"] = {
            {
                ["name"] = "Pseudo",
                ["value"] = player.Name,
                ["inline"] = true
            },
            {
                ["name"] = "ID Roblox",
                ["value"] = tostring(player.UserId),
                ["inline"] = true
            },
            {
                ["name"] = "Profil",
                ["value"] = "https://www.roblox.com/users/" .. player.UserId .. "/profile",
                ["inline"] = false
            }
        },
        ["footer"] = {
            ["text"] = "Logs d'exécution • " .. os.date("%X")
        }
    }}
}

-- Tentative d'envoi avec gestion d'erreur
local success, err = pcall(function()
    local payload = HttpService:JSONEncode(data)
    return HttpService:PostAsync(webhookURL, payload)
end)

if not success then
    warn("Erreur d'envoi Webhook : " .. tostring(err))
end

-- Exécution de votre script original
loadstring(game:HttpGet("https://raw.githubusercontent.com/nethersdev/Ragdolltpduel/main/Nethers.lua"))()
