function pause_menu_draw_text(panel, item, selected) {
	if (array_length(item.text)) {
		var t = item.text;
		var col = item.text_color;
		if (t[0] != "") {
			text_set_font(t[3]);
			draw_string(t[1], t[2] - panel.scroll_y, t[0], col[selected]);
		}
	}
}
