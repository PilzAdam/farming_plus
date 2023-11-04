-- main `S` code in init.lua
local S
-- Check if the 'farming' and 'farming.S' variables exist
if farming and farming.S then
    -- If they exist, assign 'farming.S' to 'S'
    S = farming.S
else
    -- If not, create a dummy function for 'S'
    S = function (s) return s end
    -- Print a warning message
    print("Warning: farming.S is nil, using a dummy function instead.")
end


-- Registrierung eines Handwerksgegenstands für Kartoffelsamen
minetest.register_craftitem("farming_plus:potato_seed", {
	description = ("Potato Seeds"),  -- Beschreibung des Gegenstands
	inventory_image = "farming_potato_seed.png",  -- Bild für den Gegenstand im Inventar
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:potato_1")
		-- Die Funktion 'farming.place_seed' wird aufgerufen, um die Samen zu pflanzen.
		-- Sie gibt ein aktualisiertes 'itemstack' zurück.
	end
})

-- Registrierung der ersten Entwicklungsstufe der Kartoffelpflanze
minetest.register_node("farming_plus:potato_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_potato_1.png"},  -- Textur für die Pflanze
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}  -- Auswahlbox für die Pflanze
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},  -- Gruppeneinstellungen für die Pflanze
	sounds = default.node_sound_leaves_defaults(),  -- Klangeffekte für die Pflanze
})

-- Registrierung der zweiten Entwicklungsstufe der Kartoffelpflanze (ähnlich wie oben)
minetest.register_node("farming_plus:potato_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_potato_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Registrierung der ausgewachsenen Kartoffelpflanze (ähnlich wie oben)
minetest.register_node("farming_plus:potato", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_potato_3.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:potato_seed'} },
			{ items = {'farming_plus:potato_seed'}, rarity = 2},
			{ items = {'farming_plus:potato_seed'}, rarity = 5},
			{ items = {'farming_plus:potato_item'} },
			{ items = {'farming_plus:potato_item'}, rarity = 2 },
			{ items = {'farming_plus:potato_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Registrierung des Kartoffel-Gegenstands
minetest.register_craftitem("farming_plus:potato_item", {
	description = S("Potato"),  -- Beschreibung des Gegenstands
	inventory_image = "farming_potato.png",  -- Bild für den Gegenstand im Inventar
})

-- Hinzufügen der Kartoffelpflanze zum Farming-Mod
farming.add_plant("farming_plus:potato", {"farming_plus:potato_1", "farming_plus:potato_2"}, 50, 20)

-- Alias-Registrierungen für verschiedene Namen der Kartoffelpflanze
minetest.register_alias("farming_plus:potatoe_item", "farming_plus:potato_item")
minetest.register_alias("farming_plus:potatoe_seed", "farming_plus:potato_seed")
minetest.register_alias("farming_plus:potatoe", "farming_plus:potato")
minetest.register_alias("farming_plus:potatoe_1", "farming_plus:potato_1")
minetest.register_alias("farming_plus:potatoe_2", "farming_plus:potato_2")
