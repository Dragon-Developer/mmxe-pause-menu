function pause_menu_step() {
	pause_menu_keys_update();
	var n = ds_list_size(panel_list), p, pos = [], item, item_list, panel_h;
	var previous_panel_id = panel_id, previous_item = 0, changed_item = false;
	// Update panel if we clicked on other panel
	if (mouse_check_button_released(mb_left)) {
		for (var i = 0; i < n; i++) {
			p = panel_list[| i];
			pos = p.pos;
			if (p.selectable && ds_list_size(p.items) > 0 && point_in_rect(mouse_x, mouse_y, pos)) {
				panel_id = i;	
			}
		}
	}
	// Change panel horizontally
	var move_h = key_p_right - key_p_left, move_between_panels = false;
	move_v = key_p_down - key_p_up;
	if (move_h != 0) {
		do {
			p = panel_list[| panel_id];
			move_between_panels = ds_list_size(p.items) == 0 || p.item_move == ITEM_MOVE.V;
			if (!move_between_panels && p.item_move == ITEM_MOVE.HV) {
				item_list = p.items;
				item = item_list[| p.selected_i];
				if ((item.l && move_h == -1) || (item.r && move_h == 1)) {
					move_between_panels = true;
				} else {
					previous_item = p.selected_i;
					p.selected_i = p.selected_i + move_h;
					changed_item |= (previous_item != p.selected_i);
				}
			}
			if (move_between_panels) {
				var h_panel = p.h;
				var index = (move_h + 1) / 2; // 0 = left, 1 = right
				panel_id = h_panel[index];
			}
			p = panel_list[| panel_id];
		} until (ds_list_size(p.items) > 0);
	} else if (move_v != 0) {
		p = panel_list[| panel_id];
		pos = p.pos;
		item_list = p.items;
		var len = ds_list_size(item_list);
		if (len > 0)
			previous_item = p.selected_i; 
		if (p.item_move == ITEM_MOVE.V && len > 0) {
			p.selected_i = (p.selected_i + move_v + len) mod len;
			changed_item |= (previous_item != p.selected_i);
			if (p.scroll) {
				panel_h = pos[3] - pos[1];
				var selected_i = p.selected_i;
				item = item_list[| selected_i];
				var pos2 = item.pos;
				// Skipped selected item (first to last or vice versa)
				if (abs(previous_item - selected_i) != 1) {
					p.scroll_y = (previous_item == 0 ? p.scroll_h - panel_h : 0);
				} else { // Normal Up Down
					p.scroll_y = floor((pos2[3] + pos2[1] - panel_h) / 2);
				}
			}
		}
		if (p.item_move == ITEM_MOVE.HV) {
			item = item_list[| previous_item];
			var row = item.row;
			var index_list = p.index_list;
			var first_index_row = index_list[| row];
			var row_count = ds_list_size(index_list);
			var next_row = (row + move_v + row_count) mod row_count;
			p.selected_i = index_list[| next_row] + (previous_item - first_index_row);
			var next_row2 = (next_row + move_v + row_count) mod row_count;
			if (p.selected_i >= index_list[| next_row2]) {
				p.selected_i = clamp(p.selected_i, 0, (index_list[| next_row2] - 1 + len) mod len);
			}
			changed_item |= (previous_item != p.selected_i);
		}
	}
	// Get current panel info
	p = panel_list[| panel_id];
	pos = p.pos;
	panel_h = pos[3] - pos[1];
	// Update selected item with mouse
	if (mouse_check_button_released(mb_left)) {
		if (panel_drag_y == mouse_y) panel_drag = false;
		// Mouse released inside Panel
		if (!panel_drag && point_in_rect(mouse_x, mouse_y, pos)) {
			item_list = p.items;
			previous_item = p.selected_i;
			for (var i = 0; i < ds_list_size(item_list); i++) {
				var item = item_list[| i];
				var pos2 = item.pos;
				// Mouse released inside an item
				if (point_in_rect(mouse_x - pos[0], mouse_y - pos[1] + p.scroll_y, pos2)) {
					p.selected_i = i;
					if (p.scroll)
						p.scroll_y = floor((pos2[3] + pos2[1] - panel_h) / 2);
					break;
				}
			}
			changed_item |= (previous_item != p.selected_i);
		
		}
		panel_drag = false;
	}
	// Activate panel drag (if scroll is enabled)
	if (mouse_check_button_pressed(mb_left)) {
		if (p.scroll) {
			if (point_in_rect(mouse_x, mouse_y, pos)) {
				panel_drag = true;
				panel_drag_y = mouse_y;
				panel_scroll_y = p.scroll_y;
			}
		}
	}

	// Dragging the panel
	if (panel_drag) {
		p.scroll_y = panel_scroll_y + (panel_drag_y - mouse_y);
	}
	if (p.scroll)
		p.scroll_y = clamp(p.scroll_y, 0, p.scroll_h - panel_h);
	
	// Changed Panel
	if (previous_panel_id != panel_id || changed_item) {
		previous_panel_id = panel_id;
		audio_play_sound(panel_item_sound, 0, 0);	
	}
}
