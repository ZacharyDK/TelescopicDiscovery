
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
require ("circuit-connector-sprites")

data:extend({
  {
    type = "corpse",
    name = "radiotelescope-remnants",
    icon = "__telescopic-discovery__/graphics/icons/radar.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "defensive-structure-remnants",
    order = "a-g-a",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet (1,
    {
      filename = "__telescopic-discovery__/graphics/entity/radar/remnants/radar-remnants.png",
      line_length = 1,
      width = 282,
      height = 212,
      direction_count = 1,
      shift = util.by_pixel(12, 4.5),
      scale = 0.5
    })
  },
})


data:extend({
  {
    type = "assembling-machine", --Want to be able to select deep science recipe
    name = "radiotelescope",
    icon = "__telescopic-discovery__/graphics/icons/radar.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "radiotelescope"},
    max_health = 350,
    corpse = "radiotelescope-remnants",
    icon_draw_specification = {shift = {0, -0.3}},
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["assembling-machine"],
    alert_icon_shift = util.by_pixel(0, -12),
    dying_explosion = "radar-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      },
      {
        type = "impact",
        percent = 30
      }
    },
    fluid_boxes_off_when_no_fluid_recipe = true,
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    perceived_performance = { minimum = 0.0, performance_to_activity_rate = 2.0, maximum = 3 },
    graphics_set =
    {
      animation =
      {
        layers =
        {
          {
            filename = "__telescopic-discovery__/graphics/entity/radar/radar.png",
            priority = "low",
            width = 196,
            height = 254,
            apply_projection = false,
            --direction_count = 64,
            line_length = 8,
            shift = util.by_pixel(1.0, -16.0),
            scale = 0.5,
            frame_count = 64,
            --run_mode = "forward-then-backward",
             
          },
          {
            filename = "__telescopic-discovery__/graphics/entity/radar/radar-shadow.png",
            priority = "low",
            width = 336,
            height = 170,
            apply_projection = false,
            --direction_count = 64,
            line_length = 8,
            shift = util.by_pixel(39.0, 6.0),
            draw_as_shadow = true,
            scale = 0.5,
            frame_count = 64,
            --run_mode = "forward-then-backward",
             
          }
        }
      },
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    impact_category = "metal",
    working_sound =
    {
      sound = {filename = "__base__/sound/radar.ogg", volume = 0.8, modifiers = volume_multiplier("main-menu", 2.0)},
      max_sounds_per_prototype = 3,
      use_doppler_shift = false
    },
    crafting_categories = {"data-collection"},

    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 6 }
    },
    energy_usage = "650kW",
    module_slots = 2,
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    heating_energy = "400kW",
    reset_orientation_when_frozen = true,
    frozen_patch =
    {
      filename = "__space-age__/graphics/entity/frozen/radar/radar.png",
      width = 196,
      height = 254,
      shift = util.by_pixel(1, -16),
      scale = 0.5,
      direction_count = 1
    }
  },
  {
      type = "assembling-machine",
      name = "telescopic-data-processor",
      icon = "__telescopic-discovery__/graphics/icons/cybernetics-facility-icon.png",
      icon_size = 64,
      flags = {"placeable-neutral","placeable-player", "player-creation"},
      minable = {mining_time = 0.1, result = "telescopic-data-processor"},
      max_health = 600,
      corpse = "big-scorchmark",
      dying_explosion = "medium-explosion", 
      icon_draw_specification = {shift = {0, -0.3}},
      --circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
      --circuit_connector = circuit_connector_definitions["chemical-plant"],
      collision_box = {{-1.6, -1.6}, {1.6, 1.6}},
      selection_box = {{-2.0, -2.0}, {1.2, 1.9}},
      damaged_trigger_effect = hit_effects.entity(),
      drawing_box_vertical_extension = 0.0,
      module_slots = 3,
      allowed_effects = {"consumption", "speed", "productivity", "pollution"},
      perceived_performance = { minimum = 0.0, performance_to_activity_rate = 2.0, maximum = 4 },

      graphics_set =
      {
          animation = 
          {
              layers = 
              {
                  {
                      filename = "__telescopic-discovery__/graphics/entity/cybernetics-facility/cybernetics-facility-hr-animation-1.png",
                      width = 270,
                      height = 310,
                      frame_count = 64,
                      line_length = 8,
                      scale = 0.5,
                       
                  },
                  {
                      filename = "__telescopic-discovery__/graphics/entity/cybernetics-facility/cybernetics-facility-hr-emission-1.png",
                      width = 270,
                      height = 310,
                      frame_count = 64,
                      line_length = 8,
                      scale = 0.5,
                      --draw_as_light = true,
                      blend_mode = "additive",
                       
                  },
                  {
                      filename = "__telescopic-discovery__/graphics/entity/cybernetics-facility/cybernetics-facility-hr-shadow.png",
                      --shift = util.by_pixel(8, 39),
                      width = 500,
                      height = 350,
                      frame_count = 1,
                      line_length = 1,
                      draw_as_shadow = true,
                      repeat_count = 64,
                      scale = 0.5,
                       
                  }
              },
          },
          idle_animation  =
          {
              layers =
              {
                  {
                      filename = "__telescopic-discovery__/graphics/entity/cybernetics-facility/cybernetics-facility-hr-animation-1.png",
                      width = 270,
                      height = 310,
                      frame_count = 64,
                      line_length = 8,
                      scale = 0.5,
                       
                  },
                  {
                      filename = "__telescopic-discovery__/graphics/entity/cybernetics-facility/cybernetics-facility-hr-shadow.png",
                      --shift = util.by_pixel(8, 39),
                      width = 500,
                      height = 350,
                      frame_count = 1,
                      line_length = 1,
                      draw_as_shadow = true,
                      repeat_count = 64,
                      scale = 0.5,
                       
                  }
              },
          },
      },
      impact_category = "metal-large",
      open_sound = { filename = "__base__/sound/open-close/lab-open.ogg", volume = 0.6 },
      close_sound = { filename = "__base__/sound/open-close/lab-close.ogg", volume = 0.6 },
      working_sound =
      {
        sound = { filename = "__base__/sound/lab.ogg", volume = 0.7, modifiers = { volume_multiplier("main-menu", 2.2), volume_multiplier("tips-and-tricks", 0.8) } },
        audible_distance_modifier = 0.7,
        fade_in_ticks = 4,
        fade_out_ticks = 20
      },
      crafting_speed = 1,
      energy_source =
      {
          type = "electric",
          usage_priority = "secondary-input",
          emissions_per_minute = { pollution = 4 }
      },
      energy_usage = "500kW",
      crafting_categories = {"data-processing"},

  },
})