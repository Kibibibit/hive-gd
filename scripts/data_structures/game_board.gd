extends RefCounted
class_name GameBoard


var grid: HexGrid = HexGrid.new()

func tile_empty(pos: Vector2i) -> bool:
	return grid.get_at_v(pos).tiles.is_empty()

func get_neighbours(pos: Vector2i) -> Array[Vector2i]:
	return grid.get_neighbours_v(pos)

func get_non_empty_neighbours(pos: Vector2i, exclude: Array[int] = []) -> Array[Vector2i]:
	var out: Array[Vector2i] = []
	for n in get_neighbours(pos):
		if (!tile_empty(n) && !HexGrid.get_coord_id_v(n) in exclude):
			out.append(n)
	return out

func tile_connected(pos: Vector2i, exclude: Array[int] = []) -> bool:
	for neighbour in get_neighbours(pos):
		if (!tile_empty(neighbour) && !HexGrid.get_coord_id_v(neighbour) in exclude):
			return true
	return false


func can_move_tile(tile: Tile) -> bool:
	var stack: TileStack = grid.get_at_v(tile.hex_pos)
	
	if (stack.tiles.size() > 1):
		if (stack.tiles.find(tile.get_instance_id()) < stack.tiles.size()-1):
			return false
	
	return !tile_is_connecting(tile.hex_pos)

func get_slideable_neighbours(pos: Vector2i) -> Array[Vector2i]:
	var out: Array[Vector2i] = []
	var neighbours = grid.get_neighbours_v(pos)
	for neighbour in neighbours:
		var blocking = 0
		if (!grid.get_at_v(neighbour).tiles.is_empty()):
			continue
		for n_neighbour in grid.get_neighbours_v(neighbour):
			if HexGrid.axial_distance_v(pos, n_neighbour) == 1.0:
				if (!grid.get_at_v(n_neighbour).tiles.is_empty()):
					blocking += 1
					if (blocking == 2):
						break
					continue
		if (blocking < 2):
			out.append(neighbour)
	return out

func tile_is_connecting(pos: Vector2i) -> bool:
	var tiles_to_find = grid.get_non_empty_tiles([pos])
	var stack: Array[Vector2i] = [get_non_empty_neighbours(pos)[0]]
	var explored: Array[int] = []
	while (!stack.is_empty()):
		var next = stack.pop_back()
		var next_id = HexGrid.get_coord_id_v(next)
		if (!next_id in explored):
			explored.append(next_id)
			var next_index = tiles_to_find.find(next)
			if (next_index != -1):
				tiles_to_find.remove_at(next_index)
				if (tiles_to_find.size() == 0):
					return false
				for n in get_non_empty_neighbours(next):
					stack.append(n)
	return tiles_to_find.size() != 0
