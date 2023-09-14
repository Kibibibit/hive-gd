extends Tile
class_name TileQueenBee



func get_reachable_tiles(board: GameBoard) -> Array[Vector2i]:
	var out: Array[Vector2i] = []
	for n in board.get_slideable_neighbours(hex_pos):
		if (board.tile_connected(n, [HexGrid.get_coord_id_v(hex_pos)])):
			out.append(n)
	return out
