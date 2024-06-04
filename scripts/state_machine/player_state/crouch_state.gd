extends "res://scripts/state_machine/player_state/player_base_state.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _enter_state():
	print("lol")

func _tick_state(delta):
	tick_movement(delta)
	if not Input.is_action_pressed("player_down") or Input.is_action_just_released("player_down"):
		host.state_machine.set_state("idle_run")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
