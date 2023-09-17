extends Node2D
class_name GameScreen


var game_state: GameState

func _ready() -> void:
	game_state = GameState.new()
	
	var center: Hex = Hex.axial(10,10)
	
	var positions: Array[Hex] = center.spiral(3)
	
	print(positions)
	
	
	var player_code: int = 0
	var tile_code: int = 0
	
	for i in positions.size():
		var hex: Hex = positions[i]
		var tile: Tile = game_state.players[player_code].tiles_left[tile_code]
		tile.hex = hex
		print(tile)
		var tile_node: TileNode = TileNode.new(tile)
		tile_node.position = tile.hex.to_pixel_coords()
		add_child(tile_node)
		tile_code += 1
		if (tile_code > 10):
			tile_code = 0
			player_code += 1
		if (player_code > 1):
			break
	


func _process(_delta: float) -> void:
	pass
