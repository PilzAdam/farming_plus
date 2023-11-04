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

-- Registriere den Baumsetzling für den Kakaobaum
minetest.register_node("farming_plus:cocoa_sapling", {
	description = S("Cocoa Tree Sapling"),  -- Beschreibung des Setzlings
	drawtype = "plantlike",
	tiles = {"farming_cocoa_sapling.png"},  -- Textur des Setzlings
	inventory_image = "farming_cocoa_sapling.png",  -- Bild für den Setzling im Inventar
	wield_image = "farming_cocoa_sapling.png",  -- Bild für den Setzling beim Halten
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}  -- Auswahlbox für den Setzling
	},
	groups = {dig_immediate=3, flammable=2},  -- Gruppeneinstellungen für den Setzling
	sounds = default.node_sound_defaults(),  -- Klangeffekte für den Setzling
})

-- Registriere die Kakaoblätter
minetest.register_node("farming_plus:cocoa_leaves", {
	drawtype = "allfaces_optional",
	tiles = {"farming_banana_leaves.png"},  -- Textur der Blätter
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, not_in_creative_inventory=1},
 	drop = {
		max_items = 1,
		items = {
			{
				items = {'farming_plus:cocoa_sapling'},
				rarity = 20,
			},
		}
	},
	sounds = default.node_sound_leaves_defaults(),  -- Klangeffekte für die Blätter
})

-- Registriere das Wachstum des Kakaobaums
minetest.register_abm({
	nodenames = {"farming_plus:cocoa_sapling"},
	interval = 60,
	chance = 20,
	action = function(pos, node)
		farming.generate_tree(pos, "default:tree", "farming_plus:cocoa_leaves", {"default:sand", "default:desert_sand"}, {["farming_plus:cocoa"]=20})
	end
})

-- Registriere das Erscheinen von Kakaobäumen in der Welt
minetest.register_on_generated(function(minp, maxp, blockseed)
	if math.random(1, 100) > 5 then
		return
	end
	local tmp = {x=(maxp.x-minp.x)/2+minp.x, y=(maxp.y-minp.y)/2+minp.y, z=(maxp.z-minp.z)/2+minp.z}
	local pos = minetest.find_node_near(tmp, maxp.x-minp.x, {"default:desert_sand"})
	if pos ~= nil then
		farming.generate_tree({x=pos.x, y=pos.y+1, z=pos.z}, "default:tree", "farming_plus:cocoa_leaves", {"default:sand", "default:desert_sand"}, {["farming_plus:cocoa"]=20})
	end
end)

-- Registriere den Kakaobaum selbst
minetest.register_node("farming_plus:cocoa", {
	description = S("Cocoa"),  -- Beschreibung des Baums
	tiles = {"farming_cocoa.png"},  -- Textur des Baums
	visual_scale = 0.5,
	inventory_image = "farming_cocoa.png",  -- Bild für den Baum im Inventar
	wield_image = "farming_cocoa.png",  -- Bild für den Baum beim Halten
	drawtype = "torchlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3, dig_immediate=3, flammable=2, leafdecay=3, leafdecay_drop=1},  -- Gruppeneinstellungen für den Baum
	sounds = default.node_sound_defaults(),  -- Klangeffekte für den Baum
})

-- Registriere die Kakaobohne als Handwerksgegenstand
minetest.register_craftitem("farming_plus:cocoa_bean", {
	description = "Cocoa Bean",  -- Beschreibung der Bohne
	inventory_image = "farming_cocoa_bean.png",  -- Bild für die Bohne im Inventar
})

-- Registriere das Handwerksrezept für Kakaobohnen
minetest.register_craft({
	output = "farming_plus:cocoa_bean 10",  -- Ausgabe und Menge der Bohnen
	type = "shapeless",
	recipe = {"farming_plus:cocoa"},  -- Rezept: Ein Kakaobaum wird zu Bohnen verarbeitet
})
