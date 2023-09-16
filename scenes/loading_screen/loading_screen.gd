extends Node2D
class_name LoadingScreen

signal loading_complete()


var resource_count: int = 0
var loaded_count: int = 0

var loaded_resources: Array[String] = []

func _ready() -> void:
	for sprite in Asset.SPRITES:
		ResourceLoader.load_threaded_request(sprite)
		resource_count += 1


func _process(_delta: float) -> void:
	if (loaded_count < resource_count):
		for sprite in Asset.SPRITES:
			if (!sprite in loaded_resources):
				if (ResourceLoader.load_threaded_get_status(sprite) == ResourceLoader.THREAD_LOAD_LOADED):
					loaded_resources.append(sprite)
					loaded_count+=1
		print("%s/%s Loaded" % [loaded_count, resource_count])
	else:
		loading_complete.emit()
