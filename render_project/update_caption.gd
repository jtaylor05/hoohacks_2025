extends Label

var caption_path : String = "res://captions/captions.txt"

func _process(delta: float) -> void:
	if FileAccess.file_exists(caption_path):
		var f = FileAccess.open(caption_path, FileAccess.READ)
		text = f.get_line()
		f.close()

func _on_tree_exiting() -> void:
	if FileAccess.file_exists(caption_path):
		var f = FileAccess.open(caption_path, FileAccess.READ_WRITE)
		f.store_string("Draw Something!")
