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

-- Registriere einen Handwerksgegenstand für Orangensamen
minetest.register_craftitem("farming_plus:orange_seed", {
	description = S("Orange Seeds"),  -- Beschreibung des Gegenstands
	inventory_image = "farming_orange_seed.png",  -- Bild für den Gegenstand im Inventar
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:orange_1")
		-- Die Funktion 'farming.place_seed' wird aufgerufen, um die Samen zu pflanzen.
		-- Sie gibt ein aktualisiertes 'itemstack' zurück.
	end
})

-- Registriere die erste Entwicklungsstufe des Orangenbaums
minetest.register_node("farming_plus:orange_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orange_1.png"},  -- Textur für die Pflanze
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}  -- Auswahlbox für die Pflanze
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},  -- Gruppeneinstellungen für die Pflanze
	sounds = default.node_sound_leaves_defaults(),  -- Klangeffekte für die Pflanze
})

-- Registriere die zweite Entwicklungsstufe des Orangenbaums (ähnlich wie oben)
minetest.register_node("farming_plus:orange_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orange_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Registriere die dritte Entwicklungsstufe des Orangenbaums (ähnlich wie oben)
minetest.register_node("farming_plus:orange_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_orange_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+14/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Registriere den ausgewachsenen Orangenbaum (ähnlich wie oben)
minetest.register_node("farming_plus:orange", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_orange_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:orange_seed'} },
			{ items = {'farming_plus:orange_seed'}, rarity = 2},
			{ items = {'farming_plus:orange_seed'}, rarity = 5},
			{ items = {'farming_plus:orange_item'} },
			{ items = {'farming_plus:orange_item'}, rarity = 2 },
			{ items = {'farming_plus:orange_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Registriere den Orangen-Gegenstand
minetest.register_craftitem("farming_plus:orange_item", {
	description = S("Orange"),  -- Beschreibung des Gegenstands
	inventory_image = "farming_orange.png",  -- Bild für den Gegenstand im Inventar
	on_use = minetest.item_eat(4),  -- Funktion für den Verzehr des Gegenstands
})

-- Füge den Orangenbaum zur Farming-Mod hinzu
farming.add_plant("farming_plus:orange", {"farming_plus:orange_1", "farming_plus:orange_2", "farming_plus:orange_3"}, 50, 20)
