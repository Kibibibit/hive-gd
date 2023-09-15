extends RefCounted
class_name GameState




var grid: Dictionary = {}
var tiles: Array[int] = []


func place_tile(tile: Tile) -> void:
	var tile_hex_id: int = tile.hex.get_id()
	if (!tile_hex_id in grid.keys()):
		grid[tile_hex_id] = []
	grid[tile_hex_id].append(tile.get_instance_id())
	tiles.append(tile.get_instance_id())

func remove_tile(tile: Tile) -> bool:
	var tile_hex_id: int = tile.hex.get_id()
	if (!tile_hex_id in grid.keys()):
		return false
	var index = grid[tile_hex_id].find(tile.get_instance_id())
	if (index == -1):
		return false
	
	var tile_index = tiles.find(tile.get_instance_id())
	if (tile_index == -1):
		return false
	
	grid[tile_hex_id].remove_at(index)
	if (grid[tile_hex_id].is_empty()):
		grid.erase(tile_hex_id)
	tiles.remove_at(tile_index)
	return true

func valid_edge(hex: Hex, from: Hex) -> bool:
	var hex_id: int = hex.get_id()
	if (hex_id in grid.keys()):
		return false
	for n in hex.neighbours():
		if (!space_empty(n) && n.get_id() != hex.get_id() && n.get_id() != from.get_id()):
			return true
	return false

func space_empty(hex: Hex) -> bool:
	return !hex.get_id() in grid.keys()

func can_slide_to(from: Hex, to: Hex) -> bool:
	var shared: Array[Hex] = from.shared_neighbours(to)
	var count: int = 2
	for s in shared:
		if !space_empty(s):
			count -= 1
	return count > 0

func get_slideable_neighbours(hex: Hex) -> Array[Hex]:
	var out: Array[Hex] = []
	for n in hex.neighbours():
		if (can_slide_to(hex, n)):
			out.append(n)
	return out

func get_non_empty_neighbours(hex: Hex, exclude: Array[int] = []) -> Array[Hex]:
	var out: Array[Hex] = []
	for n in hex.neighbours():
		if (!space_empty(n) && !n.get_id() in exclude):
			out.append(n)
	return out

func can_move(tile: Tile) -> bool:
	return !_tile_is_under_stack(tile) && !_move_breaks_hive(tile)

func _move_breaks_hive(tile: Tile) -> bool:
	var tiles_to_find: Array = grid.keys()
	var tile_index: int = tiles_to_find.find(tile.hex.get_id())
	if (tile_index == -1):
		print("Couldnt find tile")
		return true
	tiles_to_find.remove_at(tile_index)
	var non_empty_neighbours: Array[Hex] = get_non_empty_neighbours(tile.hex)
	if (non_empty_neighbours.is_empty()):
		print("No non empty neighbours")
		return true
	var stack: Array[Hex] = [non_empty_neighbours[0]]
	var explored: Array[int] = []
	while (!stack.is_empty()):
		var next: Hex = stack.pop_back()
		var next_id: int = next.get_id()
		if (!next_id in explored):
			explored.append(next_id)
			var next_index: int = tiles_to_find.find(next_id)
			if (next_index != -1):
				tiles_to_find.remove_at(next_index)
				if (tiles_to_find.size() == 0):
					return false
				for n in get_non_empty_neighbours(next):
					stack.append(n)
	return tiles_to_find.size() != 0

func _tile_is_under_stack(tile: Tile) -> bool:
	var tile_hex_id: int = tile.hex.get_id()
	if (space_empty(tile.hex)):
		return false
	var index = grid[tile_hex_id].find(tile.get_instance_id())
	if (index == -1):
		return false
	return index < grid[tile_hex_id].size()-1
