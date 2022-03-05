function Panel(panel_list) constructor {
    pos = [0, 0, 16, 16]; // Position and Size
	scroll = false; // Scrolling
	selected_i = 0; // Selected Item
	scroll_y = 0; // Scroll Y
	scroll_h = 0; // Scroll Height
	text_color = [colors.golden_off, colors.golden]; // Text Colors (On/Off)
	items = ds_list_create(); // Panel Items
	index_list = ds_list_create(); // Index of the first item of each row
	h = [-1, -1]; // Horizontal Transition
	surface = -1; // Surface (draw)
	selectable = true; // Can I select this panel?
	text = []; // Text info
	ds_list_add(panel_list, self);
}
function ItemBar(item) constructor {
	style = 0; // Draw Style
	unit_size = 1; // Size of an unit
	sprites = [spr_pause_bar_off, spr_pause_bar]; // On/Off sprites
	sprite = spr_pause_subtank_bar; // Static sprite (without On/Off)
	val = 0; // Value
	max_val = 0; // Max Value
	item.has_bar = true;
	// Draw Bar (panel, selected)
	function draw(panel, selected) {
		var xx = pos[0], yy = pos[1] - panel.scroll_y;
		switch (style) {
			#region Weapon Bar Style
			case 0:
				sprite = sprites[selected];
				draw_sprite(sprite, 0, xx, yy);
				for (var i = 0; i < max_val; i++) {
					draw_sprite(sprite, 1, xx, yy);	
					if (i < val)
						draw_sprite(sprite, 2, xx, yy);
					xx += unit_size;
				}
				draw_sprite(sprite, 3, xx, yy);
				break;
			#endregion
			#region Sub Tank Bar Style
			case 1:
				var ww = sprite_get_width(sprite), hh = sprite_get_height(sprite);
				var y_top = ceil((1 - val / max_val) * hh);
				draw_sprite_part(sprite, selected, 0, y_top, ww, hh, pos[0], yy + y_top);
				break;
			default:
			#endregion
		}
    }
}
function PanelItem(panel) constructor {
	icons = [noone, noone]; // Icon Sprites
	icon_pos = [0, 0]; // Icon Position
	icon_i = 0; // Icon Index
	text = []; // Text
	l = -1; // Can move to left item?
	r = -1; // Can move to right item?
	pos = [0, 0, 16, 16]; // Position and Size
	text_color = [colors.golden_off, colors.golden]; // Text Color (On/Off)
	bar = noone; // Bar
	has_bar = false; // Does this item have a bar?
	ds_list_add(panel.items, self);
}
