function point_in_rect(px, py, r) {
	return point_in_rectangle(px, py, r[0], r[1], r[2], r[3]);
}
function rect_in_rect(s, d) {
	return rectangle_in_rectangle(s[0], s[1], s[2], s[3], d[0], d[1], d[2], d[3]);
}