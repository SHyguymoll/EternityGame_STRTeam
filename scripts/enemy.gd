class_name Enemy
extends Area3D

enum EnemyTypes {JUMPING, DODGING}
var enemy_type : EnemyTypes
var speed : float

func _ready() -> void:
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = true
		elif child is Node3D:
			child.visible = false
	match enemy_type:
		EnemyTypes.JUMPING:
			$JumpObstacle.visible = true
			$JumpShape.disabled = false
			$PointsArea/JumpPointsShape.disabled = false
			$JumpSound.play()
		EnemyTypes.DODGING:
			$DodgeObstacle.visible = true
			$DodgeShape.disabled = false
			$PointsArea/DodgePointsShape.disabled = false
			$DodgeSound.play()


func _process(delta: float) -> void:
	position.x -= delta * speed


func _on_area_entered(area: Area3D) -> void:
	pass # Replace with function body.

func _on_body_entered(body):
	if body is Player: # hurt the player if they hit an obstacle
		body.hurt()
		$PointsArea.queue_free() # delete the points area if the player got hit bc they don't deserve it!!!
	pass # Replace with function body.


func _grant_points(body): # connected to body_entered - give the player a point whenever they clear an obstacle
	if body is Player:
		body.add_points()
