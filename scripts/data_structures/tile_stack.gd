extends RefCounted
class_name TileStack


var pos: Vector2i
var tiles: Array[int] = []

func _init(p: int, q:int):
	pos = Vector2i(p,q)
	
