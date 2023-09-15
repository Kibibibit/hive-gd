extends Tile
class_name TileQueenBee

func get_bug_name() -> String:
	return "queen bee"

func _valid_moves(game_state: GameState) -> Array[Hex]:
	var out: Array[Hex] = []

	for n in game_state.get_slideable_neighbours(self.hex):
		if (game_state.valid_edge(n, self.hex)):
			out.append(n)
	return out
