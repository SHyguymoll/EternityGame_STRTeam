extends State

# base state script: other states should inherit from this one

func _enter_state():
	pass

func _tick_state(delta):
	tick_movement(delta)

func tick_movement(delta): # wrapper for functions that can be overwritten in other states if they aren't needed
	apply_gravity(delta)
	apply_movement(delta)
	jump(delta)
	crouch(delta)
	dodge(delta)

func apply_movement(delta): # handle horizontal movement
	var input_dir = Input.get_axis("player_right", "player_left")
	var direction = (host.transform.basis * Vector3(0, 0, input_dir)).normalized()
	if direction:
		host.velocity.z = direction.z * host.SPEED
	else:
		host.velocity.z = move_toward(host.velocity.x, 0, host.SPEED)

func jump(delta):
	if Input.is_action_just_pressed("player_jump") and host.is_on_floor():
		host.velocity.y = host.JUMP_VELOCITY
		host.state_machine.set_state("jump")

func crouch(delta):
	if Input.is_action_just_pressed("player_down"):
		if host.is_on_floor():
			host.state_machine.set_state("crouch")
		# else: fastfall?

func dodge(delta):
	pass

func _exit_state():
	pass

func apply_gravity(delta):
	if not host.is_on_floor():
		host.velocity.y -= get_gravity() * delta

func get_gravity():
	return host.gravity
