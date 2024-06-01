extends Node3D

@onready var _ground : Node3D = $GroundPlaceholder

func _process(delta: float) -> void:
	_ground.position.z = fmod(_ground.position.z + (delta * 100), 55)
