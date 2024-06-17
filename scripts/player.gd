class_name Player
extends CharacterBody3D


const JUMP_VELOCITY = 10
const ACCELERATION = 15
const MAX_SPEED = 10

var motion : Vector2 = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * 2.5 # i could change this in the project settings but i'm anticipating a merge conflict LMAO
@onready var default_z_position : float = position.z
@onready var state_machine = $StateMachine

func _ready():
	state_machine.set_state("idle_run")

func _physics_process(delta):
	%CoordsLabel.set_text(str(velocity))
	%StateLabel.set_text(state_machine.current_state.name)
	%OtherLabel.set_text(str(state_machine.current_state.get_acceleration()))
	move_and_slide()
