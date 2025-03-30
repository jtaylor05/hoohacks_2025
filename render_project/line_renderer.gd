extends Node

var input_file : String = "res://input.txt"
var last_point : Vector3
@export var max_size : float = 20.0

func get_scale_factor(points) -> float:
	var sums = [0.0, 0.0, 0.0]
	for point in points:
		sums[0] += point[0]
		sums[1] += point[1]
		sums[2] += point[2]
	for i in range(len(sums)):
		sums[i] = sums[i] / len(points)
	return 1/sums.max()

func to_vector(point, scale = 1.0) -> Vector3:
	return Vector3(point[0], point[1], point[2]) * scale

func _process(delta: float) -> void:
	if !%PauseButton.button_pressed:
		if FileAccess.file_exists(input_file):
			var f : FileAccess = FileAccess.open(input_file, FileAccess.READ)
			
			var string_data = f.get_line().split(",")
			while true:
				var data = []
				for i in range(0, len(string_data)):
					data.append(float(string_data[i]))
				var point = to_vector(data)
				if !last_point:
					last_point = point
				else:
					var a = DebugDraw3D.new_scoped_config().set_thickness(%LineThicknessSlider.value)
					DebugDraw3D.draw_line(last_point, point, Color(0.5, 0.5, 0.5), 1000)
					last_point = point
				
				string_data = f.get_line().split(",")
				if f.eof_reached():
					break
			f.close()
			DirAccess.remove_absolute("res://input.txt")
	
