extends RefCounted
class_name Player


var tiles_left: Array[Tile]
var player_code: int


func _init(p_player_code: int) -> void:
	player_code = p_player_code
	tiles_left = [
		TileQueenBee.new(),
		TileSpider.new(),
		TileSpider.new(),
		TileBeetle.new(),
		TileBeetle.new(),
		TileGrasshopper.new(),
		TileGrasshopper.new(),
		TileGrasshopper.new(),
		TileSoldierAnt.new(),
		TileSoldierAnt.new(),
		TileSoldierAnt.new(),
	]
	for tile in tiles_left:
		tile.player_code = player_code
