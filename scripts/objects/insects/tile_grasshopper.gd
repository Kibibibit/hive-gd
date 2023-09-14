extends Tile
class_name TileGrasshopper

func get_reachable_tiles(board: GameBoard) -> Array[Vector2i]:
	var out: Array[Vector2i] = []
	for direction in HexGrid.AXIAL_DIRECTIONS:
		
		if (board.tile_empty(hex_pos+direction)):
			continue
		var check_pos: Vector2i = hex_pos+direction
		while (!board.tile_empty(check_pos)):
			check_pos+=direction
		out.append(check_pos)
	return out
