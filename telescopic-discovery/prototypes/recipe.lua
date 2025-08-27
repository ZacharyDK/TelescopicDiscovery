--TODO
-- Voyager memory Unit from astronomical data
-- Unpack voyager memory
-- radio telescope recipe + entity
-- data processor. Krastorio has quantum computer,and server rack

data:extend({
    { --TODO pressure sensitive variants. More data on Frozen planets, 
        type = "recipe",
        name = "astronomical-data",
        category ="data-collection",
        enabled = false,
        subgroup = "telescope",
        ingredients =
        {

          {type ="item", name ="writable-memory", amount = 1},
        },
  
        energy_required = 60,
        results =
        {
          {type ="item", name ="astronomical-data", amount = 1, ignored_by_productivity = 9999},
        },
        allow_productivity = false,
        allow_quality = false,
        auto_recycle = false,
        main_product ="astronomical-data",
        maximum_productivity = 1,
        order = "f",
    },
    {
        type = "recipe",
        name = "volatile-memory-unit",
        order = "f",
        category ="advanced-crafting",
        enabled = false,
        --subgroup = "telescope",
        ingredients =
        {
          {type ="item", name ="decider-combinator", amount = 1},
          {type ="item", name ="iron-gear-wheel", amount = 2},
          {type ="item", name ="copper-cable", amount = 3},
        },
        energy_required = 18,
        results =
        {
          {type ="item", name ="volatile-memory-unit", amount = 1},
        },
        main_product ="volatile-memory-unit",
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "writable-memory",
        order = "f",
        category ="advanced-crafting",
        enabled = false,
        --subgroup = "telescope",
        ingredients =
        {
          {type ="item", name ="volatile-memory-unit", amount = 4},
          {type ="item", name ="copper-cable", amount = 4},
          {type ="item", name ="electronic-circuit", amount = 1},
          {type ="item", name ="battery", amount = 2},
        },
        energy_required = 18,
        results =
        {
          {type ="item", name ="writable-memory", amount = 1},
        },
        main_product ="writable-memory",
        allow_productivity = false,
    },
    { 
      type = "recipe",
      name = "voyager-memory-unit",
      category ="advanced-crafting",
      enabled = false,
      subgroup = "telescope",
      ingredients =
      {

        {type ="item", name ="astronomical-data", amount = 16},
        {type ="item", name ="fission-reactor-equipment", amount = 1},
        {type ="item", name ="copper-cable", amount = 8},
      },

      energy_required = 12,
      results =
      {
        {type ="item", name ="voyager-memory-unit", amount = 1, ignored_by_productivity = 9999},
      },
      allow_productivity = false,
      allow_quality = false,
      auto_recycle = false,
      main_product ="voyager-memory-unit",
      maximum_productivity = 1,
      order = "g",
    },
    { 
      icons = 
      {
        {
          icon = "__telescopic-discovery__/graphics/icons/voyager-memory-unit.png",
          scale = 0.9
        },
        {
          icon = "__telescopic-discovery__/graphics/icons/astronomical-data.png",
          scale = 0.6,
        }
      },
      type = "recipe",
      name = "voyager-memory-unit-unpack",
      category ="advanced-crafting",
      enabled = false,
      subgroup = "telescope",
      ingredients =
      {

        {type ="item", name ="voyager-memory-unit", amount = 1},
      },
      energy_required = 12,
      results =
      {

        {type ="item", name ="astronomical-data", amount = 16, ignored_by_productivity = 9999},
        {type ="item", name ="fission-reactor-equipment", amount = 1, ignored_by_productivity = 9999},
        {type ="item", name ="copper-cable", amount = 8, ignored_by_productivity = 9999},
      },
      allow_productivity = false,
      allow_quality = false,
      auto_recycle = false,
      main_product ="astronomical-data",
      maximum_productivity = 1,
      order = "g",
    },
    {
      type = "recipe",
      name = "radiotelescope",
      order = "f",
      category ="advanced-crafting",
      enabled = false,
      --subgroup = "telescope",
      ingredients =
      {
        {type ="item", name ="radar", amount = 1},
        {type ="item", name ="processing-unit", amount = 5},
        {type ="item", name ="copper-cable", amount = 3},
        {type ="item", name ="accumulator", amount = 1},
      },
      energy_required = 14,
      results =
      {
        {type ="item", name ="radiotelescope", amount = 1},
      },
      main_product ="radiotelescope",
      allow_productivity = false,
    },
    {
      type = "recipe",
      name = "telescopic-data-processor",
      order = "f",
      category ="advanced-crafting",
      enabled = false,
      --subgroup = "telescope",
      ingredients =
      {
        {type ="item", name ="chemical-plant", amount = 1},
        {type ="item", name ="processing-unit", amount = 7},
        {type ="item", name ="copper-cable", amount = 12},
        {type ="item", name ="electric-engine-unit", amount = 1},
        {type ="item", name ="steel-plate", amount = 3},
        {type ="item", name ="battery", amount = 1},
      },
      energy_required = 14,
      results =
      {
        {type ="item", name ="telescopic-data-processor", amount = 1},
      },
      main_product ="telescopic-data-processor",
      allow_productivity = false,
    },
})

local function get_data_cost(input_science_pack_name)

  local out = 100
  if(string.find(input_science_pack_name,"automation")) then out= 20 end
  if(string.find(input_science_pack_name,"logistic")) then out= 30 end
  if(string.find(input_science_pack_name,"military")) then out= 35 end
  if(string.find(input_science_pack_name,"chemical")) then out= 45 end
  if(string.find(input_science_pack_name,"production")) then out= 60 end
  if(string.find(input_science_pack_name,"utility")) then out= 70 end   
  if(string.find(input_science_pack_name,"promethium")) then out= 150 end

  return out
end

local function create_data_to_science_recipe(input_science_pack_name)

    local recipe_name = input_science_pack_name .. "-from-data"
    local data_cost = get_data_cost(input_science_pack_name)
    return {
        type = "recipe",
        name = recipe_name,
        localised_name = {"", {"item-name."..input_science_pack_name}, "item-name.from-data"},
        category ="data-processing",
        enabled = true,
        subgroup = "telescope",
        ingredients =
        {
          {type ="item", name ="astronomical-data", amount = data_cost},
          {type ="item", name =input_science_pack_name, amount = 1},
        },
  
        energy_required = 80,
        results =
        {
          {type ="item", name ="writable-memory", amount = math.floor(data_cost/3), ignored_by_productivity = 9999},
          {type ="item", name =input_science_pack_name, amount = 2},
        },
        allow_productivity = true,
        allow_quality = false,
        auto_recycle = false,
        main_product =input_science_pack_name,
        maximum_productivity = 3,
        order = "g" .. tostring(data_cost),
    }
end

for s in pairs(data.raw.subgroup["science-pack"]) do
  data:extend({create_data_to_science_recipe(s)})
end