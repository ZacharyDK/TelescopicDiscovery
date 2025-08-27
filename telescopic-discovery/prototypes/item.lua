local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local simulations = require("__base__.prototypes.factoriopedia-simulations")

local data_cost_per_distance = 350 --TODO make mod setting

data:extend({
  {
    type = "item",
    name = "volatile-memory-unit",
    icon = "__telescopic-discovery__/graphics/icons/volatile-memory-unit.png",
    subgroup = "telescope",
    order = "a[memory]-a[memory-unit]",
    inventory_move_sound = item_sounds.combinator_inventory_move,
    pick_sound = item_sounds.combinator_inventory_pickup,
    drop_sound = item_sounds.combinator_inventory_move,
    stack_size = 32,
  },
  {
    type = "item",
    name = "writable-memory",
    icon = "__telescopic-discovery__/graphics/icons/writable-memory.png",
    subgroup = "telescope",
    order = "a[memory]-b[writable-memory]",
    inventory_move_sound = item_sounds.combinator_inventory_move,
    pick_sound = item_sounds.combinator_inventory_pickup,
    drop_sound = item_sounds.combinator_inventory_move,
    stack_size = 32/4,
    auto_recycle = false,
  },
  {
    type = "item",
    name = "astronomical-data",
    icon = "__telescopic-discovery__/graphics/icons/astronomical-data.png",
    subgroup = "telescope",
    order = "a[memory]-c[astronomical-data]",
    inventory_move_sound = item_sounds.combinator_inventory_move,
    pick_sound = item_sounds.combinator_inventory_pickup,
    drop_sound = item_sounds.combinator_inventory_move,
    stack_size = 32/4,
    auto_recycle = false,
    spoil_ticks = 20 * minute,
    spoil_result = "writable-memory",
  },
  {
    type = "item",
    name = "voyager-memory-unit",
    icon = "__telescopic-discovery__/graphics/icons/voyager-memory-unit.png",
    subgroup = "telescope",
    order = "a[memory]-d[voyager-memory-unit]",
    inventory_move_sound = item_sounds.combinator_inventory_move,
    pick_sound = item_sounds.combinator_inventory_pickup,
    drop_sound = item_sounds.combinator_inventory_move,
    stack_size = 32/8,
    auto_recycle = false,
  },
  {
    type = "item",
    name = "radiotelescope",
    icon = "__telescopic-discovery__/graphics/icons/radar.png",
    subgroup = "defensive-structure",
    order = "d[radar]-b[radar]",
    inventory_move_sound = item_sounds.metal_large_inventory_move,
    pick_sound = item_sounds.metal_large_inventory_pickup,
    drop_sound = item_sounds.metal_large_inventory_move,
    place_result = "radiotelescope",
    stack_size = 50,
    random_tint_color = item_tints.iron_rust
  },
  {
    type = "item",
    name = "telescopic-data-processor",
    icon = "__telescopic-discovery__/graphics/icons/cybernetics-facility-icon.png",
    subgroup = "telescope",
    order = "a[memory]-e[telescopic-data-processor]",
    inventory_move_sound = item_sounds.metal_large_inventory_move,
    pick_sound = item_sounds.metal_large_inventory_pickup,
    drop_sound = item_sounds.metal_large_inventory_move,
    place_result = "telescopic-data-processor",
    stack_size = 25,
  },

})

local function Telescopic:create_hidden_research_item(input_planet_name)
    return 	{
		type = "tool",
		name = input_planet_name .. "-discovery-progress",
		hidden = true,
		icon = "__base__/graphics/icons/signal/signal-science-pack.png",
		icon_size = 64,
		subgroup = "science-pack",
		order = "z-["..input_planet_name .. "]",
		stack_size = 200,
		default_import_location = "nauvis",
		weight = 1 * 1000 * 1000000,
		durability = 1,
        auto_recycle = false,
	}
end

local function Telescopic:create_progress_recipe_icon(input_planet_name)
    if (data.raw.planet[input_planet_name].icon == nil) then
        return {
            {
                icon = "__telescopic-discovery__/graphics/icons/radar.png",
                icon_size = 64,
            }
        }
    end

    return {
        {
            icon = data.raw.planet[input_planet_name].icon,
            icon_size = data.raw.planet[input_planet_name].icon_size,
        },
        {
            icon = "__telescopic-discovery__/graphics/icons/radar.png",
            icon_size = 64,
            scale = 0.5,
        }
    }
end


local function Telescopic:create_research_progress_recipe(input_planet_name)
    local progress_name = input_planet_name .. "-discovery-progress"
    table.insert(data.raw.lab.inputs,progress_name)
    return {
        icons = create_progress_recipe_icon(input_planet_name),
        type = "recipe",
        name = input_planet_name .. "-data-process",
        category ="data-processing",
        enabled = true,
        subgroup = "telescope",
        ingredients =
        {
          {type ="item", name ="astronomical-data", amount = 1},
        },
  
        energy_required = 120,
        results =
        {
          {type ="item", name ="writable-memory", amount = 1, ignored_by_productivity = 9999},
          {type ="research-progress", name = progress_name, amount = 1},
        },
        allow_productivity = true,
        allow_quality = false,
        auto_recycle = false,
        main_product ="writable-memory",
        maximum_productivity = 3,
        order = "f",
    }
end

local function Telescopic:does_planet_discovery_research_exist(input_planet_name)
    local test_name = "planet-disovery-" .. input_planet_name
    local out = data.raw.technology[test_name] ~= nil
    return out
end

local planet_blacklist = {}

local function Telescopic:update_planet_research(input_planet_name) -- Assuming planet research exist
    local progress_name = input_planet_name .. "-discovery-progress"
    local research_name = "planet-disovery-" .. input_planet_name
    local distance = data.raw.planet[input_planet_name]["distance"]
    local multiplier = math.log(math.floor(distance))
    local new_unit = {
        count = multiplier * data_cost_per_distance,
        ingredients = {
            { progress_name, 1 },
        },
        time = 60,
    }
    data.raw.technology[research_name][unit] = new_unit

end



--TODO create fluoroketone and water cooled variants. 
--As well as water dumping recipe and water cooling
--TOD deep astron data.


--[[
--Steps for creating a research from a recipe
1. Create hidden tool
	{
		type = "tool",
		name = "fulgoran-cryogenics-progress",
		hidden = true,
		icon = "__PlanetsLib__/graphics/icons/research-progress-product.png",
		icon_size = 64,
		subgroup = "science-pack",
		order = "j-a[cerys]-b[fulgoran-cryogenics-progress]",
		stack_size = 200,
		default_import_location = "cerys",
		weight = 1 * 1000 * 1000000,
		durability = 1,
	},
2. Add tool as lab input to prevent game from throwing no lab except science pack error
3. Ingredients to technology will be the name of the hidden item, instead of the science pack
4. Add research progress prototype to recipe 
]]

--[[
--Planning 
0. Need new recipe type - data-processing, ticks on astronomical data for spoilage, 
1. Step 1 - Create function to create research for planets with no discovery. 
2. Step 2 - Create list of planets,
3. For each planet - create a hidden tool item. Then add them to the regular lab. Also create data to discovery research progress recipe
4. For each planet, check if there is a research 
4. If there is a discovery research, get the number of science packs. Multiply by 500, and change the ingredient/unit
]]

--local planet_map = {}

for planet in pairs(data.raw.planet) do
    local exist = Telescopic.does_planet_discovery_research_exist(planet)
    if(exist) then
        data:extend({
          Telescopic.create_hidden_research_item(planet),
          Telescopic.create_research_progress_recipe(planet),
        })
        Telescopic.update_planet_research(planet)
    end
end