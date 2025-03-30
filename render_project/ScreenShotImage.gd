extends Node

func create_timer() -> void:
	var timer = get_tree().create_timer(5.0)
	timer.timeout.connect(screenshot)
	timer.timeout.connect(create_timer)

func screenshot() -> void:
	var image = get_viewport().get_texture().get_image()
	image.save_png("user://screenshot.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_timer()
