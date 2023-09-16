extends Node2D
class_name GameScreen


var game_state: GameState

func _ready() -> void:
	game_state = GameState.new()
	
	for i in game_state.players[0].tiles_left.size():
		var tile_a: TileNode = TileNode.new(game_state.players[0].tiles_left[i])
		var tile_b: TileNode = TileNode.new(game_state.players[1].tiles_left[i])
		tile_a.position.x += 32*i
		tile_b.position.x += 16 + (32*i)
		tile_b.position.y += 24
	
		add_child(tile_a)
		add_child(tile_b)
	


func _process(_delta: float) -> void:
	pass
