-- Hauptcode für 'S' in init.lua
local S

-- Überprüfe, ob die Variablen 'farming' und 'farming.S' existieren
if farming and farming.S then
    -- Wenn sie existieren, weise 'farming.S' der Variable 'S' zu
    S = farming.S
else
    -- Wenn nicht, erstelle eine Dummy-Funktion für 'S'
    S = function (s) return s end
    -- Gib eine Warnmeldung aus
    print("Warnung: farming.S ist nil, es wird stattdessen eine Dummy-Funktion verwendet.")
end

-- Registriere den Banana Tree Sapling (Banana-Baum Setzling)
minetest.register_node("farming_plus:banana_sapling", {
	description = S("Banana Tree Sapling"),  -- Beschreibung des Setzlings
	drawtype = "plantlike",
	tiles = {"farming_banana_sapling.png"},  -- Textur für den Setzling
	inventory_image = "farming_banana_sapling.png",  -- Bild für den Setzling im Inventar
	wield_image = "farming_banana_sapling.png",  -- Bild für den Setzling beim Halten
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {dig_immediate=3, flammable=2},  -- Gruppen, zu denen der Setzling gehört
	sounds = default.node_sound_defaults(),  -- Klangeffekte für den Setzling
})

-- Registriere die Banana Leaves (Banana-Blätter)
minetest.register_node("farming_plus:banana_leaves", {
	drawtype = "allfaces_optional",
	tiles = {"farming_banana_leaves.png"},  -- Textur für die Banana-Blätter
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, not_in_creative_inventory=1},  -- Gruppen für die Banana-Blätter
	drop = {
		max_items = 1,
		items = {
			{
				items = {'farming_plus:banana_sapling'},
				rarity = 20,
			},
		}
	},
	sounds = default.node_sound_leaves_defaults(),  -- Klangeffekte für die Banana-Blätter
})

-- Registriere einen ABM (Automatic Block Modifier) für das Wachstum der Banana-Bäume
minetest.register_abm({
	nodenames = {"farming_plus:banana_sapling"},
	interval = 60,
	chance = 20,
	action = function(pos, node)
		farming.generate_tree(pos, "default:tree", "farming_plus:banana_leaves", {"default:dirt", "default:dirt_with_grass"}, {["farming_plus:banana"]=20})
	end
})

-- Registriere eine Funktion, die auf der Generierung der Welt basiert und zufällig Banana-Bäume erzeugt
minetest.register_on_generated(function(minp, maxp, blockseed)
	if math.random(1, 100) > 5 then
		return
	end
	local tmp = {x=(maxp.x-minp.x)/2+minp.x, y=(maxp.y-minp.y)/2+minp.y, z=(maxp.z-minp.z)/2+minp.z}
	local pos = minetest.find_node_near(tmp, maxp.x-minp.x, {"default:dirt_with_grass"})
	if pos ~= nil then
		farming.generate_tree({x=pos.x, y=pos.y+1, z=pos.z}, "default:tree", "farming_plus:banana_leaves",  {"default:dirt", "default:dirt_with_grass"}, {["farming_plus:banana"]=10})
	end
end)

-- Registriere die Banana (Banane) als Node
minetest.register_node("farming_plus:banana", {
	description = S("Banana"),  -- Beschreibung der Banane
	tiles = {"farming_banana.png"},  -- Textur für die Banane
	inventory_image = "farming_banana.png",  -- Bild für die Banane im Inventar
	wield_image = "farming_banana.png",  -- Bild für die Banane beim Halten
	drawtype = "torchlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3, dig_immediate=3, flammable=2, leafdecay=3, leafdecay_drop=1},  -- Gruppen für die Banane
	sounds = default.node_sound_defaults(),  -- Klangeffekte für die Banane

	-- Funktion für den Verzehr der Banane
	on_use = minetest.item_eat(6),
})
