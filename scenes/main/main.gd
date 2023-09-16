extends Node2D


const LOADING: int = 0
const GAME: int = 1

var loading_screen_scene = preload("res://scenes/loading_screen/loading_screen.tscn")
var game_screen_scene = preload("res://scenes/game_screen/game_screen.tscn")

var current_scene: Node2D
var game_state: int = LOADING

func _ready():
	var loading_screen: LoadingScreen = loading_screen_scene.instantiate()
	loading_screen.loading_complete.connect(_loading_complete)
	current_scene = loading_screen
	add_child(loading_screen)


func _loading_complete():
	remove_child(current_scene)
	current_scene.queue_free()
	
	current_scene = game_screen_scene.instantiate()
	add_child(current_scene)
	
