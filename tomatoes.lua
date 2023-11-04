-- main `S` code in init.lua
local S  -- Declare a local variable named `S`
if farming.S then  -- Check if `farming.S` is not nil
    S = farming.S  -- Assign the value of `farming.S` to the local variable `S`
else
    print("Error: farming.S is nil")  -- Print an error message if `farming.S` is nil
end

-- Register a craftitem for tomato seeds
minetest.register_craftitem("farming_plus:tomato_seed", {
	description = S("Tomato Seeds"),  -- Description for the item
	inventory_image = "farming_tomato_seed.png",  -- Image for the item in inventory
	on_place = function(itemstack, placer, pointed_thing)  -- Function to execute when item is placed
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:tomato_1")  -- Place the seed and return the modified itemstack
	end
})

-- Register a node for the first stage of tomato growth
minetest.register_node("farming_plus:tomato_1", {
	paramtype = "light",  -- Parameter type for light
	walkable = false,  -- Node is not walkable
	drawtype = "plantlike",  -- Draw type is plant-like
	drop = "",  -- No items are dropped when node is dug
	tiles = {"farming_tomato_1.png"},  -- Texture for the node
	selection_box = {  -- Selection box dimensions
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},  -- Node groups and their properties
	sounds = default.node_sound_leaves_defaults(),  -- Sound settings for the node
})

-- Register a node for the second stage of tomato growth
minetest.register_node("farming_plus:tomato_2", {
	paramtype = "light",  -- Parameter type for light
	walkable = false,  -- Node is not walkable
	drawtype = "plantlike",  -- Draw type is plant-like
	drop = "",  -- No items are dropped when node is dug
	tiles = {"farming_tomato_2.png"},  -- Texture for the node
	selection_box = {  -- Selection box dimensions
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},  -- Node groups and their properties
	sounds = default.node_sound_leaves_defaults(),  -- Sound settings for the node
})

-- Register a node for the third stage of tomato growth
minetest.register_node("farming_plus:tomato_3", {
	paramtype = "light",  -- Parameter type for light
	walkable = false,  -- Node is not walkable
	drawtype = "plantlike",  -- Draw type is plant-like
	drop = "",  -- No items are dropped when node is dug
	tiles = {"farming_tomato_3.png"},  -- Texture for the node
	selection_box = {  -- Selection box dimensions
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},  -- Node groups and their properties
	sounds = default.node_sound_leaves_defaults(),  -- Sound settings for the node
})

-- Register a node for the final stage of tomato growth
minetest.register_node("farming_plus:tomato", {
	paramtype = "light",  -- Parameter type for light
	walkable = false,  -- Node is not walkable
	drawtype = "plantlike",  -- Draw type is plant-like
	tiles = {"farming_tomato_4.png"},  -- Texture for the node
	drop = {  -- Items to drop when node is dug
		max_items = 6,  -- Maximum number of items to drop
		items = {
			{ items = {'farming_plus:tomato_seed'} },
			{ items = {'farming_plus:tomato_seed'}, rarity = 2},
			{ items = {'farming_plus:tomato_seed'}, rarity = 5},
			{ items = {'farming_plus:tomato_item'} },
			{ items = {'farming_plus:tomato_item'}, rarity = 2 },
			{ items = {'farming_plus:tomato_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},  -- Node groups and their properties
	sounds = default.node_sound_leaves_defaults(),  -- Sound settings for the node
})

-- Register a craftitem for the tomato item
minetest.register_craftitem("farming_plus:tomato_item", {
	description = S("Tomato"),  -- Description for the item
	inventory_image = "farming_tomato.png",  -- Image for the item in inventory
	on_use = minetest.item_eat(4),  -- Function to execute when item is used
})

-- Add the tomato plant to the farming module, defining its growth stages and chances of growth
farming.add_plant("farming_plus:tomato", {"farming_plus:tomato_1", "farming_plus:tomato_2", "farming_plus:tomato_3"}, 50, 20)
