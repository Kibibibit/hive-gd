extends Node2D
class_name TileNode

var hex_sprite: Sprite2D
var insect_sprite: Sprite2D

func _init(tile: Tile) -> void:
	
	hex_sprite = _create_sprite(tile.get_hex_sprite())
	insect_sprite = _create_sprite(tile.get_insect_sprite())
	insect_sprite.z_index = 1
	add_child(hex_sprite)
	add_child(insect_sprite)

func _create_sprite(path: String) -> Sprite2D:
	var sprite: Sprite2D = Sprite2D.new()
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	sprite.texture = Asset.get_sprite(path)
	sprite.centered = false
	return sprite
