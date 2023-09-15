extends Tile
class_name TileBeetle


func get_bug_name() -> String:
	return "beetle"


func _valid_moves(game_state: GameState) -> Array[Hex]:
	var out: Array[Hex] = []

	for n in self.hex.neighbours():
		var can_slide: bool = game_state.can_slide_to(self.hex, n) && game_state.valid_edge(n, self.hex)
		var can_climb: bool = !game_state.space_empty(n)
		if (can_slide || can_climb):
			out.append(n)
	return out
