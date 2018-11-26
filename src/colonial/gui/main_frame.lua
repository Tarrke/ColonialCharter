

function colonial.create_button(player)
    colonial.log("Creating Basic UI for player " .. player.name)

    if (not colonial.get_button(player)) then
        mod_gui.get_button_flow(player).add({
            type = "button",
            name = "colonial_button",
            caption = { "colonial.main_button" },
        })
    end
end

function colonial.get_button(player)
    return mod_gui.get_button_flow(player)['colonial_button']
end

function colonial.toggle_frame(player)
    local frame = colonial.get_main_frame(player)
    if frame then
        frame.destroy()
    else
        colonial.create_main_frame(player)
    end

end

function colonial.get_main_frame(player)
    return mod_gui.get_frame_flow(player)['colonial_main_frame']
end

function colonial.create_main_frame(player)
    local frame = mod_gui.get_frame_flow(player).add({
        type = "frame",
        name = "colonial_main_frame",
        caption = { "colonial.frame_title" },
        direction = "vertical"
    })

    -- Create local table to hold the data
    local table = frame.add({
        type = "table",
        name = "colonial_main_frame_table",
        column_count = 2,
        draw_horizontal_line_after_headers = true
    })
    -- Headers
    table.add({
        type = "label",
        name = "colonial_colonist_type_label",
        caption = "Colonist Type"
    })
    table.add({
        type = "label",
        name = "colonial_colonist_number_label",
        caption = "Colonist Number"
    })
    -- colonist=Colonist
    table.add({
        type = "label",
        name = "colonial_colonist_label",
        caption = "Colonist"
    })
    table.add({
        type = "label",
        name = "colonial_colonist_number",
        caption = "0"
    })
    -- injured-colonist=Injured colonist
    table.add({
        type = "label",
        name = "colonial_injured_colonist_label",
        caption = "Injured Colonist"
    })
    table.add({
        type = "label",
        name = "colonial_injured_colonist_number",
        caption = "0"
    })
    -- tired-colonist=Tierd colonist
    table.add({
        type = "label",
        name = "colonial_tired_colonist_label",
        caption = "Tired Colonist"
    })
    table.add({
        type = "label",
        name = "colonial_tired_colonist_number",
        caption = "0"
    })
    -- deceased-colonist=Deceased colonist
    table.add({
        type = "label",
        name = "colonial_deceased_colonist_label",
        caption = "Deceased Colonist"
    })
    table.add({
        type = "label",
        name = "colonial_deceased_colonist_number",
        caption = "0"
    })
end

-- Global update function
function colonial.update_main_frame()
    for _, player in pairs(game.players) do
        colonial.refresh_main_frame(player)
    end
end

-- Update frame for player
function colonial.refresh_main_frame(player)
    -- if no frame then do nothing
    if not colonial.get_main_frame(player) then
        return
    end

    colonial.log("updating main frame")
    -- iterate on all surfaces
    for _, s in pairs(game.surfaces) do
        local entities = s.find_entities_filtered{force="player"}
        local colonist_count = 0
        local injured_count = 0
        local tired_count = 0
        local deceased_count = 0
        -- then iterate on all entities own by the player
        -- TODO: test this in multiplayer maps
        for _, entitie in pairs(entities) do
            colonist_count = colonist_count + entitie.get_item_count("colonist")
            injured_count  = injured_count  + entitie.get_item_count("injured-colonist")
            tired_count    = tired_count    + entitie.get_item_count("tired-colonist")
            deceased_count = deceased_count + entitie.get_item_count("deceased-colonist")
        end
    end

    -- display information on the frame
    local table = colonial.get_main_frame(player)["colonial_main_frame_table"]
    table["colonial_colonist_number"].caption          = colonist_count
    table["colonial_injured_colonist_number"].caption  = injured_count
    table["colonial_tired_colonist_number"].caption    = tired_count
    table["colonial_deceased_colonist_number"].caption = deceased_count
end