extends Node3D


func _ready() -> void:
	global_position = Vector3(28.49, 0.38, -7.439)
	global_rotation_degrees.y = 90


func _process(delta: float) -> void:
	position.x -= 100 * delta
	if position.x < -22.94:
		queue_free()
