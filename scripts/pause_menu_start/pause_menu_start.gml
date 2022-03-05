function pause_menu_start() {
	var p, item_index;
	player_sprite = spr_x_idle;
	player_sprite_pos = [191, 68];

	text_init();
	palette_init();
	load_weapon_names();
	load_subtanks();
	enum ITEM_MOVE {
		H, V, HV
	}

	pause_menu_keys_update();
	pause_bg = spr_pause_menu_background;

	panel_id = 0; // 0 = Weapons, 1 = Subtanks, 2 = Settings
	panel_list = ds_list_create();
	panel_drag = false;
	panel_drag_y = 0;
	panel_scroll_y = 0;

	panel_item_sound = snd_item_changed;

	#region Weapons
	p = new Panel(panel_list);
	with (p) {
		name = "weapons";
		pos = [34, 16, 157, 224];
		scroll = true;
		h = [2, 1];
		item_move = ITEM_MOVE.V;
		for (var i = 0; i < array_length(global.weapon_names); i++) {
			var item = new PanelItem(p);
			var _x = 14, _y = 16 + i*20;
			with (item) {
				icons = [spr_pause_weapon_icons_off, spr_pause_weapon_icons];
				icon_pos = [_x, _y];
				icon_i = i;
				pos = [_x, _y - 2, _x + 128, _y + 18];
				text = [global.weapon_names[i], _x + 20, _y, text_fonts.style];
				bar = new ItemBar(item);
				with (bar) {
					pos = [_x + 24, _y + 8];
					val = 28;
					max_val = 28;
					unit_size = 2;
				}
			}
			scroll_h = _y + 32;
		}
	}
	#endregion
	#region Sub Tanks
	p = new Panel(panel_list)
	with (p) {
		name = "sub_tanks";
		text = ["SUB TANKS", 14, 14, text_fonts.style];
		pos = [163, 123, 253, 224];
		h = [0, 2];
		item_move = ITEM_MOVE.HV;
		item_index = 0;
		for (var i = 0; i < global.subtank_types; i++) { // Row
			ds_list_add(index_list, item_index); 
			for (var j = 0; j < global.subtank_count[i]; j++) { // Column
				if (global.subtank[i][j]) {
					var item = new PanelItem(p);
					with (item) {
						var _x = 22 + j*40, _y = 38 + i*32;
						icons = [spr_pause_subtank_icons_off, spr_pause_subtank_icons];
						icon_pos = [_x, _y];
						icon_i = i;
						pos = [_x - 8, _y - 8, _x + 24, _y + 24];
						text = [global.subtank_char[i], _x - 8, _y, text_fonts.style];
						l = j == 0;
						r = j == global.subtank_count[i] - 1;
						row = i;
						bar = new ItemBar(item);
						with (bar) {
							pos = [_x + 6, _y];
							val = global.subtank_energy[i][j];
							max_val = global.subtank_energy_max[i][j];
							sprite = spr_pause_subtank_bar;
							style = 1;
						}
					}
				}
				item_index++;
			}
		}
	}
	#endregion
	#region Settings
	p = new Panel(panel_list);
	with (p) {
		name = "settings";
		pos = [259, 123, 286, 224];
		h = [1, 0];
		item_move = ITEM_MOVE.V;
		for (var i = 0; i < 3; i++) {
			var item = new PanelItem(p);
			with (item) {
				var _x = 6, _y = 13 + i*32;
				icons = [spr_pause_setting_icons_off, spr_pause_setting_icons];
				icon_pos = [_x, _y];
				icon_i = i;
				pos = [_x - 2, _y - 2, _x + 18, _y + 18];
			}
		}
	}
	#endregion
}
