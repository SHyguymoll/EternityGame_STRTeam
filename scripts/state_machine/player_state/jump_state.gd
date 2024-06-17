extends "res://scripts/state_machine/player_state/player_base_state.gd"

func _tick_state(delta):
	tick_movement(delta)
	if not Input.is_action_pressed("player_jump") and host.velocity.y > (host.JUMP_VELOCITY/1.5):
		host.velocity.y = host.JUMP_VELOCITY / 1.5
		host.state_machine.set_state("idle_run")
	if host.is_on_floor() and host.velocity.y == 0:
		host.state_machine.set_state("idle_run")
