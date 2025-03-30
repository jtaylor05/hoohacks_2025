extends Node

var points : Array = []

func to_vector(point) -> Vector3:
	return Vector3(point[0], point[1], point[2])

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var input = ReadFileData.get_next_input()
	if input:
		input.append(%LineThicknessSlider.value)
		points.append(input)
	if points.is_empty():
		return
	
	for i in range(1, len(points)):
		var a = DebugDraw3D.new_scoped_config().set_thickness(points[i-1][3])
		var first_point = to_vector(points[i-1])
		var last_point  = to_vector(points[i])
		DebugDraw3D.draw_line(first_point, last_point, Color(0.5, 0.5, 0.5))
	
