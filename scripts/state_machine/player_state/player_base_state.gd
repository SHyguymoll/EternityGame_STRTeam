extends State

@export var allow_horizontal_input := true

# base state script: other states should inherit from this one

func _enter_state():
	host.anim_state.travel("RunWalkBlend")
	pass

func _tick_state(delta):
	tick_movement(delta)

func tick_movement(delta): # wrapper for functions that can be overwritten in other states if they aren't needed
	apply_gravity(delta)
	apply_movement(delta)
	jump(delta)
	#crouch(delta)
	dodge(delta)

func apply_movement(delta): # handle horizontal movement
	var input_dir = Input.get_axis("player_left", "player_right")
	var direction = (host.transform.basis * Vector3(input_dir, 0, 0)).normalized()
	host.motion.x = get_acceleration() * input_dir * delta
	if direction and allow_horizontal_input:
		host.velocity.x += host.motion.x
		host.velocity.x = clamp(host.velocity.x, -get_max_speed(), get_max_speed())
	else:
		host.velocity.x = move_toward(host.velocity.x, 0, get_acceleration() * delta)
	host.run_speed = lerpf(host.run_speed, 1.0, 0.1)
	host.animation_tree.set("parameters/RunWalkBlend/blend_position", host.run_speed)

func jump(delta):
	if Input.is_action_just_pressed("player_jump") and host.is_on_floor():
		host.velocity.y += host.JUMP_VELOCITY
		host.state_machine.set_state("jump")

func crouch(delta):
	if Input.is_action_just_pressed("player_down"):
		if host.is_on_floor():
			host.state_machine.set_state("crouch")
		# else: fastfall?

func dodge(delta):
	if Input.is_action_just_pressed("player_action"):
		if host.is_on_floor():
			host.state_machine.set_state("dodge")
	pass

func _exit_state():
	pass

func apply_gravity(delta):
	if not host.is_on_floor():
		host.velocity.y -= get_gravity() * delta

func get_gravity():
	return host.gravity

func get_acceleration():
	return host.ACCELERATION

func get_max_speed():
	return host.MAX_SPEED
