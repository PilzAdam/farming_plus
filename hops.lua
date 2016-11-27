minetest.register_craftitem("farming_plus:hops_seed", {
	description = "hops Seeds",
	inventory_image = "farming_hops_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "farming_plus:hops_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})

minetest.register_node("farming_plus:hops_1", {
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_hops_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:hops_2", {
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_hops_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+12/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:hops", {
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_hops.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'farming_plus:hops_seed'} },
			{ items = {'farming_plus:hops_seed'}, rarity = 2},
			{ items = {'farming_plus:hops_seed'}, rarity = 5},
			{ items = {'farming_plus:hops_cone'} },
			{ items = {'farming_plus:hops_cone'}, rarity = 2 },
			{ items = {'farming_plus:hops_cone'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("farming_plus:hops_cone", {
	description = "Hops cone",
	inventory_image = "farming_hops_cone.png",
})

minetest.register_craftitem("farming_plus:hops_crude_beer_mix", {
	description = "Crude beer mix",
	inventory_image = "farming_hops_crude_mix.png",
})

minetest.register_craftitem("farming_plus:hops_fine_beer_mix", {
	description = "Fine beer mix",
	inventory_image = "farming_hops_fine_mix.png",
})

minetest.register_craft({
	type = "shapeless",	
	output = "farming_plus:hops_crude_beer_mix",
	recipe = {"farming_plus:hops_cone","bucket:bucket_water"},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craft({
	type = "cooking",	
	output = "farming_plus:hops_fine_beer_mix",
	recipe = "farming_plus:hops_crude_beer_mix",
	cooktime = 10,
})

farming:add_plant("farming_plus:hops", {"farming_plus:hops_1", "farming_plus:hops_2"}, 50, 20)

-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming_plus:hops_seed",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming_plus:hops_cone",
	burntime = 1
})