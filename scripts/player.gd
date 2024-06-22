class_name Player
extends CharacterBody3D

const DEFAULT_HEALTH : int = 2
const MAX_HEALTH : int = DEFAULT_HEALTH

const JUMP_VELOCITY : int = 15
const ACCELERATION : int = 15
const MAX_SPEED : int = 10
const DODGE_DISTANCE : float = 0.75
const DODGE_TIME : float = 0.5
const BUFFER_FRAME : float = 0.15

@onready var state_machine = $StateMachine
@onready var animation_tree = $AnimationTree
@onready var anim_state : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var default_z_position : float = position.z
var run_speed : float = 0.0

var current_health : int = DEFAULT_HEALTH
var points : int = 0

var motion : Vector2 = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * 6 # i could change this in the project settings but i'm anticipating a merge conflict LMAO

func _ready():
	state_machine.set_state("idle_run")

func hurt():
	run_speed = 0.0
	if current_health - 1 < 0:
		die()
	else:
		current_health -= 1

func add_health(value : int):
	if not current_health + value > MAX_HEALTH:
		current_health += value
	else:
		current_health = MAX_HEALTH

func add_points():
	points += 1
	if points % 50 == 0:
		add_health(1)

func die():
	# replace with actual death sequence
	get_tree().reload_current_scene()

func _physics_process(delta):
	%CoordsLabel.set_text("Health: " + str(current_health))
	%StateLabel.set_text("Score: " + str(points))
	move_and_slide()
