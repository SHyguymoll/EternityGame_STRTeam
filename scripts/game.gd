extends Node3D

@onready var _ground : Node3D = $GroundPlaceholder
var time_in_game : float = 0.0
var time_since_enemy : float = 0.5

const ENEMY_SPAWN_MOD_GAP : float = 0.05
const ENEMY_SPAWN_TIME_GAP : float = 3.0
const INITIAL_PEACE : float = 10.0
const GROUND_END : float = 50
@export var enemy_scene : PackedScene

@export var ragdoll : PackedScene

func _ready() -> void:
	$ColorRect.visible = false

func _process(delta: float) -> void:
	_ground.position.x = fmod(_ground.position.x - (delta * 50), GROUND_END)
	time_in_game += delta
	time_since_enemy = max(time_since_enemy - delta, 0.0)
	if time_since_enemy != 0.0: # no initial enemy jumpscares
		return
	if fmod(time_in_game, ENEMY_SPAWN_TIME_GAP / max(1.0, ((time_in_game - INITIAL_PEACE + 0.001)/INITIAL_PEACE))) < ENEMY_SPAWN_MOD_GAP:
		var new_enemy : Enemy = enemy_scene.instantiate()
		new_enemy.enemy_type = randi_range(0, len(Enemy.EnemyTypes) - 1)
		new_enemy.speed = 20
		print(new_enemy, " ", Enemy.EnemyTypes.keys()[new_enemy.enemy_type])
		$Enemies.add_child(new_enemy)
		time_since_enemy = 0.5


@onready var background_elements = [preload("res://assets/models/game_ready/House.gltf")]
@onready var background_script = preload("res://scripts/background.gd")

func spawn_background_element():
	var new_element : Node3D = background_elements.pick_random().instantiate()
	new_element.set_script(background_script)
	$BackgroundElements.add_child(new_element)


func _on_enemy_destroyer_area_entered(area: Area3D) -> void:
	area.queue_free()

func _enemy_hit_player(player_area: Area3D):
	pass


func _on_player_game_over() -> void:
	var ragdo = ragdoll.instantiate()
	ragdo.global_position = $Player.global_position
	add_child(ragdo)
	$Player.queue_free()
	$ColorRect/ScoreLabel.text = "Time Lasted: " + str(time_in_game) + " Seconds"
	$ColorRect.visible = true


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_background_element_timer_timeout() -> void:
	spawn_background_element()
