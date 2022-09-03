---- vim:fdm=marker:foldlevel=0
local wezterm = require 'wezterm'
local act = wezterm.action

-- Show which key table is active in the status area {{{
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = name .. "       "
  end
  window:set_right_status(name or "")
end)
-- }}}

return {
	debug_key_events=true,
	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.2,
	},
	-- color_scheme = "Chalk",
	color_scheme = "CGA",
	-- color_scheme = "Adventure",
	window_background_opacity = 1.00,
	window_background_image = "/Users/takeshifujita/Pictures/hime.jpeg",
	window_background_image_hsb = {
		brightness = 0.02,
		-- saturation = 0.1,
	},

	font = wezterm.font("UDEV Gothic NF", {weight="Bold", stretch="Normal", style="Normal"}),
	-- font = wezterm.font("CodeNewRoman Nerd Font", {weight="Medium", stretch="Normal", style="Normal"}),
	font_size = 13,
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.1,
		brightness = 1.1,
	},
	line_height = 1.1,
	cell_width = 1.0,
	freetype_load_flags="NO_BITMAP",
	disable_default_key_bindings = false,
		-- navigation w/ leader key
		-- leader = {key="Space", mods="CTRL", timeout_milliseconds=5000},
		keys = {
			{key="=", mods="CMD", action=act.IncreaseFontSize},
			{key="-", mods="CMD", action=act.DecreaseFontSize},
			{key="0", mods="CMD", action=act.ResetFontSize},
			-- {key="enter", mods="CTRL", action=act.SendKey{key="raw:\x1b[13;5u"}},

			{key="f", mods="CTRL", action=act.Multiple{
				-- act.SetPaneZoomState(false),
				act.ActivateKeyTable{
					name = "FOCUS",
					one_shot=true,
					-- timeout_milliseconds=1000,
					replace_current=true,
				},
			}},
			{key="f", mods="CTRL|SHIFT", action=act.ActivateKeyTable{
					name = "RESIZE",
					one_shot=false,
					replace_current=true,
			}},
		},
		key_tables = {
			FOCUS = {
				-- tab focus
				{key="1", action=act.ActivateTab(0)},
				{key="2", action=act.ActivateTab(1)},
				{key="3", action=act.ActivateTab(2)},
				{key="4", action=act.ActivateTab(3)},
				{key="5", action=act.ActivateTab(4)},
				{key="6", action=act.ActivateTab(5)},
				{key="7", action=act.ActivateTab(6)},
				{key="8", action=act.ActivateTab(7)},
				{key="9", action=act.ActivateTab(8)},
				{key="0", action=act.ActivateTab(9)},
				{key=".", action=act.ActivateTabRelative(1)},
				{key=",", action=act.ActivateTabRelative(-1)},
				{key="n", action=act.SpawnTab 'CurrentPaneDomain'},

				-- pane focus
				{key="h", action=act.ActivatePaneDirection("Left")},
				{key="j", action=act.ActivatePaneDirection("Down")},
				{key="k", action=act.ActivatePaneDirection("Up")},
				{key="l", action=act.ActivatePaneDirection("Right")},
				-- {key="LeftArrow",  action=act.ActivatePaneDirection("Left")},
				-- {key="DownArrow",  action=act.ActivatePaneDirection("Down")},
				-- {key="UpArrow",    action=act.ActivatePaneDirection("Up")},
				-- {key="RightArrow", action=act.ActivatePaneDirection("Right")},

				-- pane split
				{key="LeftArrow", action=act.SplitPane{direction="Left",  size={Percent=50}}},
				{key="DownArrow", action=act.SplitPane{direction="Down",  size={Percent=50}}},
				{key="UpArrow", action=act.SplitPane{direction="Up",    size={Percent=50}}},
				{key="RightArrow", action=act.SplitPane{direction="Right", size={Percent=50}}},
				-- {key="a", action=act.SplitPane{direction="Left",  size={Percent=50}}},
				-- {key="s", action=act.SplitPane{direction="Down",  size={Percent=50}}},
				-- {key="w", action=act.SplitPane{direction="Up",    size={Percent=50}}},
				-- {key="d", action=act.SplitPane{direction="Right", size={Percent=50}}},

				{key="q",      action=act.CloseCurrentPane{confirm=true}},
			},
			RESIZE = {
				-- pane size modification
				{key="h", action=act.AdjustPaneSize{"Left", 1}},
				{key="j", action=act.AdjustPaneSize{"Down", 1}},
				{key="k", action=act.AdjustPaneSize{"Up", 1}},
				{key="l", action=act.AdjustPaneSize{"Right", 1}},
				-- {key="LeftArrow",  action=act.AdjustPaneSize{"Left", 1}},
				-- {key="DownArrow",  action=act.AdjustPaneSize{"Down", 1}},
				-- {key="UpArrow",    action=act.AdjustPaneSize{"Up", 1}},
				-- {key="RightArrow", action=act.AdjustPaneSize{"Right", 1}},

				-- Cancel the mode by pressing "f"
				{key="f",      action="PopKeyTable"},
				{key="Enter",  action="PopKeyTable"},
				{key="Escape", action="PopKeyTable"},
				{key="i",      action=act.Multiple{"PopKeyTable", act.SendKey{key="i"}}},
			},
		},
}
