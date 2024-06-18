extends "res://scripts/state_machine/player_state/player_base_state.gd"


func _enter_state():
	host.animation_player.play("crouch")
	pass

func _tick_state(delta):
	tick_movement(delta)
	if not Input.is_action_pressed("player_down") or Input.is_action_just_released("player_down"):
		host.state_machine.set_state("idle_run")

func jump(delta):
	pass

func _exit_state():
	host.animation_player.play("idle")

func get_acceleration():
	return host.ACCELERATION * 0.6
