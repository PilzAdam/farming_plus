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

-- Register a craftitem for pumpkin seeds
minetest.register_craftitem(":farming:pumpkin_seed", {
    description = S("Pumpkin Seed"),  -- Localized description using 'S'
    inventory_image = "farming_pumpkin_seed.png",
    on_place = function(itemstack, placer, pointed_thing)
        -- Call the 'farming.place_seed' function
        return farming.place_seed(itemstack, placer, pointed_thing, "farming:pumpkin_1")
    end
})

-- Register the first stage of the pumpkin plant
minetest.register_node(":farming:pumpkin_1", {
    paramtype = "light",
    sunlight_propagates = true,
    drawtype = "nodebox",
    drop = "",
    tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
        },
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
        },
    },
    groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
    sounds = default.node_sound_wood_defaults(),
})

-- Register the second stage of the pumpkin plant
minetest.register_node(":farming:pumpkin_2", {
    paramtype = "light",
    sunlight_propagates = true,
    drawtype = "nodebox",
    drop = "",
    tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
    node_box = {
        type = "fixed",
        fixed = {
            {-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
        },
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
        },
    },
    groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
    sounds = default.node_sound_wood_defaults(),
})

-- Register the fully grown pumpkin plant
minetest.register_node(":farming:pumpkin", {
    description = S("Pumpkin"),  -- Localized description using 'S'
    paramtype2 = "facedir",
    tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
    groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1},
    sounds = default.node_sound_wood_defaults(),
    
    on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
        if tool and string.match(tool, "sword") then
            node.name = "farming:pumpkin_face"
            minetest.set_node(pos, node)
            puncher:get_inventory():add_item("main", ItemStack("farming:pumpkin_seed"))
            if math.random(1, 5) == 1 then
                puncher:get_inventory():add_item("main", ItemStack("farming:pumpkin_seed"))
            end
        end
    end
})

-- Add the pumpkin plant to farming mod
farming.add_plant("farming:pumpkin", {"farming:pumpkin_1", "farming:pumpkin_2"}, 80, 20)

-- Register a node for a carved pumpkin face
minetest.register_node(":farming:pumpkin_face", {
    description = S("Pumpkin Face"),  -- Localized description using 'S'
    paramtype2 = "facedir",
    tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_face.png"},
    groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1},
    sounds = default.node_sound_wood_defaults(),
})

-- Register a node for a carved pumpkin face with light
minetest.register_node(":farming:pumpkin_face_light", {
    description = S("Pumpkin Face With Light"),  -- Localized description using 'S'
    paramtype2 = "facedir",
    light_source = LIGHT_MAX-2,
    tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_face_light.png"},
    groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
    sounds = default.node_sound_wood_defaults(),
})

-- Register a craft recipe to combine a carved pumpkin face with a torch
minetest.register_craft({
    type = "shapeless",
    output = "farming:pumpkin_face_light",
    recipe = {"farming:pumpkin_face", "default:torch"}
})

-- Register a node for a big pumpkin
minetest.register_node(":farming:big_pumpkin", {
    description = S("Big Pumpkin"),  -- Localized description using 'S'
    paramtype2 = "facedir",
    tiles = {"farming_pumpkin_big_side.png"},
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -1, 1, 1.5, 1}
        }
    },
    groups = {choppy=1, oddly_breakable_by_hand=1, flammable=2},
    sounds = default.node_sound_wood_defaults(),
    
    -- Function to run after placing a big pumpkin
    after_place_node = function(pos, placer)
        -- Iterate through surrounding blocks
        for dx=-1,1 do
            for dy=0,1 do
                for dz=-1,1 do
                    pos.x = pos.x+dx
                    pos.y = pos.y+dy
                    pos.z = pos.z+dz
                    if dx ~= 0 or dy ~= 0 or dz ~= 0 then
                        if minetest.get_node(pos).name ~= "air" then
                            pos.x = pos.x-dx
                            pos.y = pos.y-dy
                            pos.z = pos.z-dz
                            -- Remove the big pumpkin if there's an obstruction
                            minetest.remove_node(pos)
                            minetest.after(0.1, function(placer)
                                local inv = placer:get_inventory()
                                local index = placer:get_wield_index()
                                inv:set_stack("main", index, ItemStack("farming:big_pumpkin"))
                            end, placer)
                            return
                        end
                    end
                    pos.x = pos.x-dx
                    pos.y = pos.y-dy
                    pos.z = pos.z-dz
                end
            end
        end
        -- Create the structure of the big pumpkin
        for dy=0,1 do
            pos.y = pos.y+dy
            pos.z = pos.z+1
            minetest.set_node(pos, {name="farming:big_pumpkin_side", param2=2})
            pos.x = pos.x-1
            minetest.set_node(pos, {name="farming:big_pumpkin_corner", param2=2})
            pos.x = pos.x+1
            pos.z = pos.z-2
            minetest.set_node(pos, {name="farming:big_pumpkin_side", param2=4})
            pos.x = pos.x+1
            minetest.set_node(pos, {name="farming:big_pumpkin_corner", param2=4})
            pos.z = pos.z+1
            minetest.set_node(pos, {name="farming:big_pumpkin_side", param2=3})
            pos.z = pos.z+1
            minetest.set_node(pos, {name="farming:big_pumpkin_corner", param2=3})
            pos.z = pos.z-1
            pos.x = pos.x-2
            minetest.set_node(pos, {name="farming:big_pumpkin_side", param2=1})
            pos.z = pos.z-1
            minetest.set_node(pos, {name="farming:big_pumpkin_corner", param2=1})
            pos.z = pos.z+1
            pos.x = pos.x+1
            pos.y = pos.y-dy
        end
        pos.y = pos.y+1
        minetest.set_node(pos, {name="farming:big_pumpkin_top"})
    end,
    
    -- Function to run after destructing a big pumpkin
    after_destruct = function(pos, oldnode)
        -- Iterate through surrounding blocks
        for dx=-1,1 do
            for dy=0,1 do
                for dz=-1,1 do
                    pos.x = pos.x+dx
                    pos.y = pos.y+dy
                    pos.z = pos.z+dz
                    local name = minetest.get_node(pos).name
                    -- Remove any big pumpkin-related nodes
                    if string.find(name, "farming:big_pumpkin") then
                        minetest.remove_node(pos)
                    end
                    pos.x = pos.x-dx
                    pos.y = pos.y-dy
                    pos.z = pos.z-dz
                end
            end
        end
    end
})

-- Register nodes for the sides and corners of a big pumpkin
minetest.register_node(":farming:big_pumpkin_side", {
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    tiles = {"farming_pumpkin_big_top_side.png", "farming_pumpkin_big_side.png"},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0.5, 0.5}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {0, 0, 0, 0, 0, 0}
        }
    },
    groups = {not_in_creative_inventory=1},
})

minetest.register_node(":farming:big_pumpkin_corner", {
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    tiles = {"farming_pumpkin_big_top_corner.png", "farming_pumpkin_big_side.png"},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0, 0.5, 0.5}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {0, 0, 0, 0, 0, 0}
        }
    },
    groups = {not_in_creative_inventory=1},
})

minetest.register_node(":farming:big_pumpkin_top", {
    paramtype = "light",
    sunlight_propagates = true,
    tiles = {"farming_pumpkin_big_top.png"},
    selection_box = {
        type = "fixed",
        fixed = {
            {0, 0, 0, 0, 0, 0}
        }
    },
    groups = {not_in_creative_inventory=1},
})

-- Register a craft recipe to obtain a big pumpkin from a bucket of water and a pumpkin
minetest.register_craft({
    type = "shapeless",
    output = "farming:big_pumpkin",
    recipe = {"bucket:bucket_water", "farming:pumpkin"},
    replacements = {
        {"bucket:bucket_water", "bucket:bucket_empty"}
    }
})

-- Register a scarecrow node
local box1 = {
    {-1, -8, -1, 1, 8, 1},
}

local box2 = {
    {-1, -8, -1, 1, 8, 1},
    {-12, -8, -1, 12, -7, 1},
    {-5, -2, -5, 5, 8, 5}
}

for j,list in ipairs(box1) do
    for i,int in ipairs(list) do
        list[i] = int/16
    end
    box1[j] = list
end

for j,list in ipairs(box2) do
    for i,int in ipairs(list) do
        list[i] = int/16
    end
    box2[j] = list
end

minetest.register_node
