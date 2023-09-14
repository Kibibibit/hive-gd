extends Tile
class_name TileSpider

const MAX_SPIDER_RANGE: int = 3

func get_reachable_tiles(board: GameBoard) -> Array[Vector2i]:
	return dfs_step(board, 0, hex_pos, [], [])



func dfs_step(board: GameBoard, depth: int, next: Vector2i, explored:Array[int], out:Array[Vector2i]):
	var next_id: int = HexGrid.get_coord_id_v(next)
	if (depth > MAX_SPIDER_RANGE || (next_id == HexGrid.get_coord_id_v(hex_pos) && depth != 0)):
		return out
	if (!next_id in explored):
		var non_empty_neighbours: Array[Vector2i] = board.get_non_empty_neighbours(next, [HexGrid.get_coord_id_v(hex_pos)])
		if (next != hex_pos && non_empty_neighbours.size() > 0):
			out.append(next)
		explored.append(next_id)
		
		
		for neighbour in board.get_slideable_neighbours(next):
			for n in board.get_non_empty_neighbours(neighbour, [next_id, HexGrid.get_coord_id_v(hex_pos)]):
				if (n in non_empty_neighbours && n != next):
					var new_tiles = dfs_step(board, depth+1, neighbour, explored, out)
					for tile in new_tiles:
						if (!tile in out):
							out.append(tile)
							
					break
	return out
					
	
