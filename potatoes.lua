minetest.register_craftitem("farming_plus:potatoe_seed", {
	description = "Potatoe Seeds",
	inventory_image = "farming_potatoe_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "farming_plus:potatoe_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})

minetest.register_node("farming_plus:potatoe_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_potatoe_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:potatoe_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_potatoe_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:potatoe", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_potatoe_3.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:potatoe_seed'} },
			{ items = {'farming_plus:potatoe_seed'}, rarity = 2},
			{ items = {'farming_plus:potatoe_seed'}, rarity = 5},
			{ items = {'farming_plus:potatoe_item'} },
			{ items = {'farming_plus:potatoe_item'}, rarity = 2 },
			{ items = {'farming_plus:potatoe_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("farming_plus:potatoe_item", {
	description = "Potatoe",
	inventory_image = "farming_potatoe.png",
})

farming:add_plant("farming_plus:potatoe", {"farming_plus:potatoe_1", "farming_plus:potatoe_2"}, 50, 20)
