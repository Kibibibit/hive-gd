extends Node

const ASSET_PATH: String = "res://assets"
const SPRITE_PATH: String = "%s/sprites" % ASSET_PATH

const SPRITE_HEX_WHITE: String = "%s/hex_white.png" % SPRITE_PATH
const SPRITE_BLACK_WHITE: String = "%s/hex_black.png" % SPRITE_PATH
const SPRITE_BEETLE: String = "%s/beetle.png" % SPRITE_PATH
const SPRITE_GRASSHOPPER: String = "%s/grasshopper.png" % SPRITE_PATH
const SPRITE_QUEEN_BEE: String = "%s/queen_bee.png" % SPRITE_PATH
const SPRITE_SOLDIER_ANT: String = "%s/soldier_ant.png" % SPRITE_PATH
const SPRITE_SPIDER: String = "%s/spider.png" % SPRITE_PATH

const SPRITES: Array[String] = [
	SPRITE_HEX_WHITE,
	SPRITE_BLACK_WHITE,
	SPRITE_BEETLE,
	SPRITE_GRASSHOPPER,
	SPRITE_QUEEN_BEE,
	SPRITE_SOLDIER_ANT,
	SPRITE_SPIDER
]

var sprite_map: Dictionary = {}

func get_sprite(path: String) -> CompressedTexture2D:
	if (!path in sprite_map.keys()):
		sprite_map[path] = ResourceLoader.load_threaded_get(path)
	
	return sprite_map[path] as CompressedTexture2D
