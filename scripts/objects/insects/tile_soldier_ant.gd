extends Tile
class_name TileSoldierAnt

func get_bug_name() -> String:
	return "soldier ant"

func _valid_moves(game_state: GameState) -> Array[Hex]:
	var out: Array[Hex] = []

	var current_id: int = self.hex.get_id()
	var explored: Array[int] = []
	var stack: Array[Hex] = [self.hex]
	
	while !stack.is_empty():
		var next: Hex = stack.pop_back()
		var next_id: int = next.get_id()
		if (!next_id in explored):
			explored.append(next_id)
			if (next_id != current_id):
				out.append(next)
			for neighbour in game_state.get_slideable_neighbours(next):
				if (
					game_state.valid_edge(neighbour, self.hex) && 
					!neighbour.get_id() in explored
				):
					stack.append(neighbour)
	
	return out
