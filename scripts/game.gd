extends Node3D

@onready var _ground : Node3D = $GroundPlaceholder

func _process(delta: float) -> void:
	_ground.position.x = fmod(_ground.position.x - (delta * 100), 100)
func _on_enemy_destroyer_area_entered(area: Area3D) -> void:
	area.queue_free()
	pass
