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

-- Registriere das Saatgut für Karotten
minetest.register_craftitem("farming_plus:carrot_seed", {
	description = S("Carrot Seeds"),  -- Beschreibung des Saatguts
	inventory_image = "farming_carrot_seed.png",  -- Bild für das Saatgut im Inventar
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:carrot_1")
	end
})

-- Registriere die erste Phase der Karottenpflanze
minetest.register_node("farming_plus:carrot_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_carrot_1.png"},  -- Textur für die erste Phase
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),  -- Klangeffekte für die Pflanze
})

-- Registriere die zweite Phase der Karottenpflanze
minetest.register_node("farming_plus:carrot_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_carrot_2.png"},  -- Textur für die zweite Phase
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),  -- Klangeffekte für die Pflanze
})

-- Registriere die dritte Phase der Karottenpflanze
minetest.register_node("farming_plus:carrot_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_carrot_3.png"},  -- Textur für die dritte Phase
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+12/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),  -- Klangeffekte für die Pflanze
})

-- Registriere die reife Karottenpflanze
minetest.register_node("farming_plus:carrot", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_carrot_4.png"},  -- Textur für reife Karotten
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:carrot_seed'} },
			{ items = {'farming_plus:carrot_seed'}, rarity = 2},
			{ items = {'farming_plus:carrot_seed'}, rarity = 5},
			{ items = {'farming_plus:carrot_item'} },
			{ items = {'farming_plus:carrot_item'}, rarity = 2 },
			{ items = {'farming_plus:carrot_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),  -- Klangeffekte für die Pflanze
})

-- Registriere die Karotten als Handwerksgegenstand
minetest.register_craftitem("farming_plus:carrot_item", {
	description = S("Carrot"),  -- Beschreibung der Karotte
	inventory_image = "farming_carrot.png",  -- Bild für die Karotte im Inventar
	on_use = minetest.item_eat(3),  -- Essen der Karotte gibt 3 Lebenspunkte zurück
})

-- Füge die Karottenpflanze zur Liste der anbaubaren Pflanzen hinzu
farming.add_plant("farming_plus:carrot", {"farming_plus:carrot_1", "farming_plus:carrot_2", "farming_plus:carrot_3"}, 50, 20)
