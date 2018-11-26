--[[
    File grouping some helpful functions about logging into the game
]]

function colonial.log(message)
    if type(message) == 'table' then
        message = serpent.dump(message) .. ' [' .. #message .. ']'
    end
    message = "" .. message or '<nil>'

    if game then
        for _, p in pairs(game.players) do
            if (colonial.show_log(p)) then
                p.print("Colonial: " .. message)
            end
        end
    else
        error(serpent.dump(message, { compact = false, nocode = true, indent = ' ' }))
    end
end

-- TODO: add setting into the game
function colonial.show_log(player)
    -- return settings.get_player_settings(player)["colonial-show-log"].value
    return true
end