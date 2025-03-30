extends Node

var last_length : int = 0
var buffer : Array = []
var input_file : String = "res://input.txt"

func loop_read() -> void:
	var data = _read_line(input_file)
	get_tree().create_timer(10.5).timeout.connect(loop_read)
	if data:
		for line in data:
			buffer.append(line)

func _read_line(file_path : String):
	var lines = []
	if FileAccess.file_exists(file_path):
		var f : FileAccess = FileAccess.open(file_path, FileAccess.READ)
		
		if f.get_length() == last_length:
			print("File hasn't changed")
			return null
		else:
			last_length = f.get_length()
		
		var string_data = f.get_line().split(",")
		while true:
			var data = []
			for i in range(0, len(string_data)):
				data.append(float(string_data[i]))
			lines.append(data)
			string_data = f.get_line().split(",")
			if f.eof_reached():
				break
		f.close()
	else:
		return null
	return lines

func get_next_input():
	if !buffer.is_empty():
		return buffer.pop_front()
	return null

func _ready() -> void:
	var data = _read_line(input_file)
	get_tree().create_timer(10.5).timeout.connect(loop_read)
	if data:
		for line in data:
			buffer.append(line)
