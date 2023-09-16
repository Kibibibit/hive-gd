extends RefCounted
class_name Tile


var hex: Hex
var player_code: int




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


func get_hex_sprite() -> String:
	if (player_code == PlayerCode.BLACK):
		return Asset.SPRITE_BLACK_WHITE
	else:
		return Asset.SPRITE_HEX_WHITE

func get_insect_sprite() -> String:
	return "IMPLEMENT ME"
