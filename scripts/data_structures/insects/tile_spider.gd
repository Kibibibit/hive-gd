extends Tile
class_name TileSpider

const MAX_SPIDER_RANGE: int = 3

func get_bug_name() -> String:
	return "spider"

func _valid_moves(game_state: GameState) -> Array[Hex]:
	return dfs_step(game_state, 0, self.hex, [], [])


func dfs_step(game_state: GameState, depth: int, next: Hex, explored:Array[int], out:Array[Hex]):
	var next_id: int = next.get_id()
	var hex_id: int = self.hex.get_id()
	if (depth > MAX_SPIDER_RANGE || (next_id == hex_id && depth != 0)):
		return out
	if (!next_id in explored):
		var non_empty_neighbours: Array[Hex] = game_state.get_non_empty_neighbours(next, [hex_id])
		var non_empty_neighbours_ids: Array[int] = []
		for n in non_empty_neighbours:
			non_empty_neighbours_ids.append(n.get_id())
		if (next_id != hex_id && non_empty_neighbours.size() > 0):
			out.append(next)
		explored.append(next_id)
		
		for neighbour in game_state.get_slideable_neighbours(next):
			for n in game_state.get_non_empty_neighbours(neighbour, [next_id, hex_id]):
				if (n.get_id() in non_empty_neighbours_ids && n.get_id() != next_id):
					var new_tiles = dfs_step(game_state, depth+1, neighbour, explored, out)
					for tile in new_tiles:
						if (!tile in out):
							out.append(tile)
							
					break
	return out
					
	

func get_insect_sprite() -> String:
	return Asset.SPRITE_SPIDER
