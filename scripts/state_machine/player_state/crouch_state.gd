extends "res://scripts/state_machine/player_state/player_base_state.gd"


func _enter_state():
	pass

func _tick_state(delta):
	tick_movement(delta)
	if not Input.is_action_pressed("player_down") or Input.is_action_just_released("player_down"):
		host.state_machine.set_state("idle_run")

func get_acceleration():
	return host.ACCELERATION * 0.6
