function load_subtanks() {
	enum subtank_types {
		energy,
		weapon,
		length
	}
	global.subtank_types = subtank_types.length;
	global.subtank_count[subtank_types.energy] = 2;
	global.subtank_count[subtank_types.weapon] = 1;
	for (var s = 0; s < 2; s++) {
		for (var i = 0; i < 2; i++) {
			global.subtank[s][i] = true;
			global.subtank_energy[s][i] = 28;
			global.subtank_energy_max[s][i] = 28;
		}
	}
	global.subtank_energy[subtank_types.energy][1] = 14;

	global.subtank_char[subtank_types.energy] = "E";
	global.subtank_char[subtank_types.weapon] = "W";
}
