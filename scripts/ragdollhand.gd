extends RigidBody3D

func _ready() -> void:
	$Hand/AnimationPlayer.play("B_Dodge")
	$Hand/AnimationPlayer.advance(0)
	linear_velocity = Vector3(randf_range(-20, -7), randf_range(2, 8), 0)
	angular_velocity = Vector3(randf_range(-10, 10), randf_range(-10, 10), randf_range(-10, 10))
