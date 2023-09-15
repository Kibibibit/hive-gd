extends Tile
class_name TileGrasshopper


func get_bug_name() -> String:
	return "grasshopper"


func _valid_moves(game_state: GameState) -> Array[Hex]:
	var out: Array[Hex] = []

	for direction in Hex.directions():
		if (game_state.space_empty(self.hex.add(direction))):
			continue
		var check_pos: Hex = self.hex.add(direction)
		while (!game_state.space_empty(check_pos)):
			check_pos = check_pos.add(direction)
		out.append(check_pos)
	return out
