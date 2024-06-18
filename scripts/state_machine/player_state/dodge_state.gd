extends "res://scripts/state_machine/player_state/player_base_state.gd"

# increases until desired time
var timer = 0

func _enter_state():
	# move the player toward the camera
	var tween = get_tree().create_tween()
	tween.tween_property(host, "position:z", host.DODGE_DISTANCE, 0.1)
	pass

func _tick_state(delta):
	tick_movement(delta)
	timer += delta
	if timer >= host.DODGE_TIME or not Input.is_action_pressed("player_action"): # player can let go of the button to release the dodge early
		host.state_machine.set_state("idle_run")

func jump(delta):
	pass

func _exit_state():
	timer = 0
	var tween = get_tree().create_tween() # there's probably a better way to do this but idk it 😭
	tween.tween_property(host, "position:z", 0, 0.1)
	pass
