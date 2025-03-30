extends Node

var buffer : Array = []

func _read_line(file_path : String):
	var lines = []
	if FileAccess.file_exists(file_path):
		var f : FileAccess = FileAccess.open(file_path, FileAccess.READ)
		
		var string_data = f.get_line().split(",")
		while true:
			var data = []
			for i in range(0, len(string_data)):
				data.append(float(string_data[i]))
			lines.append(data)
			string_data = f.get_line().split(",")
			if f.eof_reached():
				break
	else:
		return null
	return lines

func get_next_input():
	if !buffer.is_empty():
		return buffer.pop_front()
	return null

func _ready() -> void:
	var data = _read_line("res://input.txt")
	if data:
		for line in data:
			buffer.append(line)
