local function does_planet_discovery_research_exist(input_planet_name)
    if (input_planet_name == nil) then
      return false
    end
    local test_name = "planet-discovery-" .. input_planet_name
    --log(serpent.block(test_name))
    local out = (data.raw.technology[test_name] ~= nil)
    --log(serpent.block(data.raw.technology[test_name] ~= nil))
    return out
end
-- Planet discovery researches can't have more than one science pack or the recipe progress (for research) won't work
local function clean_planet_research(input_planet_name)
    local research_name = "planet-discovery-" .. input_planet_name
    local ingredients = table.deepcopy(data.raw.technology[research_name]["unit"]['ingredients']) --don't want to modify the table we are iterating through. 
        --log(serpent.block(planet))
    --
    --log(serpent.block("-------"))

    local new_ingredients = {}

    for k,v in pairs(ingredients) do
        log(serpent.block("k="))
        log(serpent.block(k))
        log(serpent.block("v="))
        log(serpent.block(v))
        if (string.find(tostring(v),input_planet_name) or string.find(tostring(v),"discovery") ) then 
            new_ingredients[#new_ingredients] = v
        end
    end
    data.raw.technology[research_name]["unit"]['ingredients'] = new_ingredients
end 





--[[
for planet in pairs(data.raw["planet"]) do
    local exist = does_planet_discovery_research_exist(planet)
    --log(serpent.block(planet))
    --log(serpent.block(exist))
    --log(serpent.block("-------"))
    if(exist) then
        clean_planet_research(planet)
    end
end

for planet in pairs(data.raw["space-location"]) do
    local exist = does_planet_discovery_research_exist(planet)
    --log(serpent.block(planet))
    --log(serpent.block(exist))
    --log(serpent.block("-------"))
    if(exist) then
        clean_planet_research(planet)
    end
end
--]]
--[[
if mods["secretas"] then
    local ingredients = table.deepcopy(data.raw.technology["science-pack-productivity"]["unit"]['ingredients'])

    for k,v in pairs(ingredients) do
        if (string.find(tostring(v),"discovery")) then --
            table.remove(data.raw.technology["science-pack-productivity"]["unit"]['ingredients'],k)
        end
    end
end
--]]