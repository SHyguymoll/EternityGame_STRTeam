extends Node3D

@onready var _ground : Node3D = $GroundPlaceholder
var time_in_game : float = 0.0
var time_since_enemy : float = 0.0

const ENEMY_SPAWN_CHANCE : float = 0.8
@export var enemy_scene : PackedScene

func _process(delta: float) -> void:
	_ground.position.x = fmod(_ground.position.x - (delta * 100), 100)
	time_in_game += delta
	time_since_enemy += delta
	if randf() * clampf(time_since_enemy/10.0, 0.0, 1.0) > ENEMY_SPAWN_CHANCE:
		var new_enemy : Enemy = enemy_scene.instantiate()
		new_enemy.enemy_type = randi_range(0, len(Enemy.EnemyTypes) - 1)
		$Enemies.add_child(new_enemy)
		time_since_enemy = 0.0


func _on_enemy_destroyer_area_entered(area: Area3D) -> void:
	area.queue_free()
	pass
