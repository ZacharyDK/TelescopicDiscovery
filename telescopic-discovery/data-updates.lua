--Need to go overdark science's changes
local data_cost_per_distance = 350 --TODO make mod setting

for planet in pairs(data.raw.planet) do
    local exist = Telescopic.does_planet_discovery_research_exist(planet)
    if(exist) then
        Telescopic.update_planet_research(planet)
    end
end