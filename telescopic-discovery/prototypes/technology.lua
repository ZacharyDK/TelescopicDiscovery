data:extend({
  {
    type = "technology",
    name = "radiotelescope",
    icon = "__telescopic-discovery__/graphics/technology/radar.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "volatile-memory-unit"
      },
      {
        type = "unlock-recipe",
        recipe = "writable-memory"
      },
      {
        type = "unlock-recipe",
        recipe = "astronomical-data"
      },
      {
        type = "unlock-recipe",
        recipe = "voyager-memory-unit"
      },
      {
        type = "unlock-recipe",
        recipe = "voyager-memory-unit-unpack"
      },
      {
        type = "unlock-recipe",
        recipe = "radiotelescope"
      },
      {
        type = "unlock-recipe",
        recipe = "telescopic-data-processor"
      },
    },
    prerequisites = {"rocket-silo"},
    unit =
    {
      count = 1000,

      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 60
    }
  },
})