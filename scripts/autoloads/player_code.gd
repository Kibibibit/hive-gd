extends Node

const BLACK: int = 0
const WHITE: int = 1


func player_name(player_code: int) -> String:
	if (player_code == BLACK):
		return "black"
	else:
		return "white"
