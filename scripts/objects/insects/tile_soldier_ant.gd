extends Tile
class_name TileSoldierAnt



func get_reachable_tiles(board: GameBoard) -> Array[Vector2i]:
	var current_pos: int = HexGrid.get_coord_id_v(hex_pos)
	
	var explored: Array[int] = []
	var stack: Array[Vector2i] = [hex_pos]
	var out: Array[Vector2i] = []
	
	while !stack.is_empty():
		var next: Vector2i = stack.pop_back()
		var next_id: int = HexGrid.get_coord_id_v(next)
		
		if (!next_id in explored):
			explored.append(next_id)
			if (next_id != current_pos):
				out.append(next)
			for neighbour in board.get_slideable_neighbours(next):
				if (
					board.tile_connected(neighbour, [current_pos]) && 
					board.tile_empty(neighbour) && 
					!HexGrid.get_coord_id_v(neighbour) in explored
				):
					stack.append(neighbour)
			
	
	return out
