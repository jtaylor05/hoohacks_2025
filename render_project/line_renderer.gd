extends Node

var points : Array = []

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
		var input = ReadFileData.get_next_input()
		if input:
			input.append(%LineThicknessSlider.value)
			points.append(input)
		if points.is_empty():
			return
	
	for i in range(1, len(points)):
		var a = DebugDraw3D.new_scoped_config().set_thickness(points[i-1][3])
		var scale = get_scale_factor(points) * max_size
		var first_point = to_vector(points[i-1], scale)
		var last_point  = to_vector(points[i], scale)
		DebugDraw3D.draw_line(first_point, last_point, Color(0.5, 0.5, 0.5))
	
