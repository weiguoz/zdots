local M = {}

function M.scheme_dark_or_light(term, dark_scheme, light_scheme)
  if term.gui.get_appearance():find "Dark" then
    return dark_scheme
  else
    return light_scheme
  end
end

return M
