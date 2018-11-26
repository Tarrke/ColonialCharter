
require "mod-gui"
require "colonial/colonial"

script.on_event(defines.events.on_rocket_launched, function(event)
    local rocket = event.rocket
    if rocket.get_item_count("satellite") < 1 then
     remote.call("silo_script", "set_show_launched_without_satellite", false)
    end
end)

script.on_init(colonial.mod_init)

script.on_configuration_changed(setup_remote_call)

script.on_event(defines.events.on_research_finished, function(event)
    if event.research.name == 'colonial-charter' then
        function setup_remote_call()
            remote.call(interface_name, "set_show_launched_without_satellite", false)
        end
    end
end)

script.on_event(defines.events.on_research_finished, function(event)
    if event.research.name == 'colonial-charter' then
         remote.call("silo_script", "add_tracked_item", "colony-ship")
    end
end)

-- When a player is joining, create the UI for them
script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    colonial.create_button(player)
end)

-- register on gui click event
script.on_event(defines.events.on_gui_click, function(event)
    colonial.on_gui_click(event)
end)

script.on_event(defines.events.on_tick, function(event)
    if( event.tick % 60 == 0) then
        colonial.update_main_frame()
    end
end)

--[[
    Setup Remote Call
    Feels like interface_name should be somthing else...
]]
function setup_remote_call()
    remote.call(interface_name, "set_show_launched_without_satellite", false)
end