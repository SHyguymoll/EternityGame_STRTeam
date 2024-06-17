class_name Player
extends CharacterBody3D


const JUMP_VELOCITY = 4.5
const ACCELERATION = 8
const MAX_SPEED = 20

var motion : Vector2 = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var default_z_position : float = position.z
@onready var state_machine = $StateMachine

func _ready():
	state_machine.set_state("idle_run")

func _physics_process(delta):
	%CoordsLabel.set_text(str(position))
	%StateLabel.set_text(state_machine.current_state.name)
	move_and_slide()
