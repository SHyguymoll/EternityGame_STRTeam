class_name Player
extends CharacterBody3D

const JUMP_VELOCITY : int = 15
const ACCELERATION : int = 15
const MAX_SPEED : int = 10
const DODGE_DISTANCE : float = 0.5
const DODGE_TIME : float = 0.5
const BUFFER_FRAME : float = 0.1

@onready var state_machine = $StateMachine
@onready var animation_player = $AnimationPlayer
@onready var default_z_position : float = position.z

var motion : Vector2 = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * 6 # i could change this in the project settings but i'm anticipating a merge conflict LMAO

func _ready():
	state_machine.set_state("idle_run")

func _physics_process(delta):
	%CoordsLabel.set_text(str(velocity))
	%StateLabel.set_text(state_machine.current_state.name)
	%OtherLabel.set_text(str(state_machine.current_state.get_acceleration()))
	move_and_slide()
