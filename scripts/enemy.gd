class_name Enemy
extends Area3D

enum EnemyTypes {JUMPING, DODGING}
var enemy_type : EnemyTypes
var speed : float

func _ready() -> void:
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = true
		else:
			child.visible = false
	match enemy_type:
		EnemyTypes.JUMPING:
			$JumpObstacle.visible = true
			$JumpShape.disabled = false
		EnemyTypes.DODGING:
			$DodgeObstacle.visible = true
			$DodgeShape.disabled = false


func _process(delta: float) -> void:
	position.x -= delta * speed


func _on_area_entered(area: Area3D) -> void:
	pass # Replace with function body.
