draw_sprite(pause_bg, 0, 0, 0);
draw_sprite(player_sprite, 0, player_sprite_pos[0], player_sprite_pos[1]);
draw_self();
n = ds_list_size(panel_list);
// Draw Panels
for (var i = 0; i < n; i++) {
	var p = panel_list[| i];
	var pos = p.pos;
	var w = pos[2] - pos[0], h = pos[3] - pos[1];
	if (!surface_exists(p.surface))
		p.surface = surface_create(w, h);
	var surf = p.surface;
	if (!surface_exists(surf)) continue;
	surface_set_target(surf);
	draw_clear_alpha(c_white, 0);
	var _y = p.scroll_y;
	pause_menu_draw_text(p, p, panel_id == i);	
	// Draw Items
	var item_list = p.items;
	for (var j = 0; j < ds_list_size(item_list); j++) {
		var selected = (panel_id == i) && (j == p.selected_i);
		var item = item_list[| j];
		var icons = item.icons;
		var spr = icons[selected];
		var icon_pos = item.icon_pos;
		if (sprite_exists(spr)) {
			draw_sprite(spr, item.icon_i, icon_pos[0], icon_pos[1]-_y);
		}
		if (item.has_bar)
			item.bar.draw(p, selected);
		pause_menu_draw_text(p, item, selected);
	}
	surface_reset_target();
	draw_surface(surf, pos[0], pos[1]);
}