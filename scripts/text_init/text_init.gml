function text_init() {
	enum text_fonts {
		normal,
		big,
		style,
		custom
	}
	global.text_font_array[text_fonts.normal] = [spr_text_font_normal, 33, 7];
	global.text_font_array[text_fonts.big] = [spr_text_font_normal, 65, 8];
	global.text_font_array[text_fonts.style] = [spr_text_font_style, 65-19, 8];

	text_set_font(text_fonts.normal);


}
