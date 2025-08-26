--TODO
-- Voyager memory Unit from astronomical data
-- Unpack voyager memory
-- radio telescope recipe + entity
-- data processor.

data:extend({
    {
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
        allow_productivity = true,
    },
})