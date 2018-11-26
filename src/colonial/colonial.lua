--[[
    This is the main entry point of the mod
]]

if not colonial then
    colonial = {}
end

-- Helper Functions
require "colonial/logging"

-- UIs
require "colonial/gui/main_frame"

function colonial.mod_init()
    colonial.log("Setting up the Colonial Charter mod")
    -- TODO: I don't know why this fails now...
    -- setup_remote_call()

    -- Creating the Main Button
    for _, player in pairs(game.players) do
        colonial.create_button(player)
    end
end

function colonial.on_gui_click(event)
    local player = game.players[event.player_index]
    local element = event.element
    colonial.log("On Gui Click .." .. element.name .. " -- " .. player.name)
    if element.name == "colonial_button" then
        colonial.log("Toggle main frame")
        colonial.toggle_frame(player)
    end
end