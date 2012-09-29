farming.seeds = {
	["farming:wheat_seed"]=20,
	["farming:cotton_seed"]=30,
	["farming:pumpkin_seed"]=60,
	["farming_plus:strawberry_seed"]=30,
	["farming_plus:rhubarb_seed"]=30,
	["farming_plus:potatoe_seed"]=30,
	["farming_plus:tomato_seed"]=30,
	["farming_plus:orange_seed"]=30,
	["farming_plus:carrot_seed"]=30,
}

-- ========= ALIASES FOR FARMING MOD BY SAPIER =========
-- potatoe -> potatoe
minetest.register_alias("farming:potatoe_node", "farming_plus:potatoe")
--minetest.register_alias("farming:potatoe", "farming:potatoe_item") cant do this
minetest.register_alias("farming:potatoe_straw", "farming_plus:potatoe")
minetest.register_alias("farming:seed_potatoe", "farming_plus:potatoe_seed")
for lvl = 1, 6, 1 do
	minetest.register_entity(":farming:potatoe_lvl"..lvl, {
		on_activate = function(self, staticdata)
			minetest.env:set_node(self.object:getpos(), {name="farming_plus:potatoe_1"})
		end
	})
end

-- ========= RUBBER =========
dofile(minetest.get_modpath("farming_plus").."/rubber.lua")

-- ========= STRAWBERRIES =========
dofile(minetest.get_modpath("farming_plus").."/strawberries.lua")

-- ========= RHUBARB =========
dofile(minetest.get_modpath("farming_plus").."/rhubarb.lua")

-- ========= POTATOES =========
dofile(minetest.get_modpath("farming_plus").."/potatoes.lua")

-- ========= TOMATOES =========
dofile(minetest.get_modpath("farming_plus").."/tomatoes.lua")

-- ========= ORANGES =========
dofile(minetest.get_modpath("farming_plus").."/oranges.lua")

-- ========= BANANAS =========
dofile(minetest.get_modpath("farming_plus").."/bananas.lua")

-- ========= CARROTS =========
dofile(minetest.get_modpath("farming_plus").."/carrots.lua")

-- ========= COCOA =========
dofile(minetest.get_modpath("farming_plus").."/cocoa.lua")
