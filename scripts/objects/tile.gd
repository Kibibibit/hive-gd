extends Node2D
class_name Tile


var hex: Hex
var hex_pos: Vector2i
var player: int


func get_bug_name() -> String:
	return "ABSTARCT TILE!"


func get_valid_moves(game_state: GameState) -> Array[Hex]:
	if (game_state.can_move(self)):
		return _valid_moves(game_state)
	else:
		return []


func _valid_moves(_game_state: GameState) -> Array[Hex]:
	print("IMPLEMENT ME")
	return []
