-- main `S` code in init.lua
local S  -- Declare a local variable named `S`
if farming.S then  -- Check if `farming.S` is not nil
    S = farming.S  -- Assign the value of `farming.S` to the local variable `S`
else
    print("Error: farming.S is nil")  -- Print an error message if `farming.S` is nil
end

-- Register a node for weed
minetest.register_node(":farming:weed", {
	description = S("Weed"),  -- Description for the node
	paramtype = "light",  -- Parameter type for light
	sunlight_propagates = true,  -- Allow sunlight to propagate through the node
	walkable = false,  -- Node is not walkable
	drawtype = "plantlike",  -- Draw type is plant-like
	tiles = {"farming_weed.png"},  -- Texture for the node
	inventory_image = "farming_weed.png",  -- Image for the node in inventory
	selection_box = {  -- Selection box dimensions
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+4/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2,plant=1},  -- Node groups and their properties
	sounds = default.node_sound_leaves_defaults(),  -- Sound settings for the node
})

-- Register an Active Block Modifier (ABM) to handle soil wetness and weed growth
minetest.register_abm({
	nodenames = {"farming:soil_wet", "farming:soil"},  -- Nodes to which the ABM applies
	interval = 50,  -- Interval (in seconds) at which the ABM is executed
	chance = 10,  -- Chance of the ABM being executed at each interval
	action = function(pos, node)  -- Function to execute when the ABM is triggered
		if minetest.find_node_near(pos, 4, {"farming:scarecrow", "farming:scarecrow_light"}) ~= nil then
			return  -- Exit if a scarecrow is found nearby
		end
		pos.y = pos.y+1  -- Adjust the y-coordinate of the position
		if minetest.get_node(pos).name == "air" then  -- Check if the node at the new position is air
			node.name = "farming:weed"  -- Set the name of the node to "farming:weed"
			minetest.set_node(pos, node)  -- Set the node at the new position to "farming:weed"
		end
	end
})

-- ========= FUEL =========
-- Register a crafting recipe for using weed as fuel
minetest.register_craft({
	type = "fuel",  -- Type of craft is fuel
	recipe = "farming:weed",  -- Recipe is weed
	burntime = 1  -- Burn time is 1
})
