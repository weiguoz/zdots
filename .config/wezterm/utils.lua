local M = {}

function M.scheme_light_or_dark(term, light_scheme, dark_scheme)
  if term.gui.get_appearance():find "Dark" then
    return dark_scheme
  end
  return light_scheme
end

return M
