local term = require("wezterm")

return function(config)
    config.keys = config.keys or {}
    table.insert(config.keys, {
        key = "f",
        mods = "CMD",
        action = term.action_callback(function(window, pane)
            local selection = window:get_selection_text_for_pane(pane) or ""
            local has_uppercase = selection:match("%u") ~= nil
            local pattern = has_uppercase
            and { CaseSensitiveString = selection }
            or { CaseInSensitiveString = selection }
            term.log_info("selection: " .. selection)
            term.log_info("has_uppercase: " .. tostring(has_uppercase))

            window:perform_action(term.action.Search(pattern), pane)
        end),
    })
    return config
end
