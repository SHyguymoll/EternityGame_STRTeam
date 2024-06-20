extends "res://scripts/state_machine/player_state/player_base_state.gd"

var buffer_timer : float = 0.0
var buffered : bool = false

func _enter_state():
	reset_buffers()

func _tick_state(delta):
	tick_movement(delta)
	if buffered:
		buffer_timer += delta
	if Input.is_action_just_pressed("player_jump") and not buffered and not host.is_on_floor(): # enable buffer
		buffered = true
	if not Input.is_action_pressed("player_jump") and host.velocity.y > (host.JUMP_VELOCITY/1.5):
		host.velocity.y = host.JUMP_VELOCITY / 1.5
	if host.is_on_floor() and host.velocity.y == 0:
		if buffered and buffer_timer < host.BUFFER_FRAME:
			reset_buffers()
			host.velocity.y += host.JUMP_VELOCITY
			host.state_machine.set_state("jump")
		else:
			host.state_machine.set_state("idle_run")

func _exit_state():
	reset_buffers()

func reset_buffers():
	buffer_timer = 0.0
	buffered = false

func get_gravity():
	return host.gravity
