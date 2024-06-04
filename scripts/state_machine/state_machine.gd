extends Node

# unintentional plagiarism i'm not looking at annabelle's state machine this time i've just used it too many times and can probably replicate it from memory

@onready var host : Player = get_parent()
var current_state : State
var states = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	await populate_states()
	pass # Replace with function body.

func populate_states(): # populate states from child nodes of state machine
	for child in get_children():
		if child is State:
			states[child.name] = child
	print(states)
	return

func set_state(state_name : String):
	if states.has(state_name):
		if current_state: # don't unset the state if there's no state set or else the machine cries
			current_state._exit_state()
		# set the state
		current_state = states[state_name]
		current_state.host = host
		current_state._enter_state()
	else: # use a normal print because every previous iteration of this system just crashes
		print("error: state '%s' not found" % state_name)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state._tick_state(delta)
	pass
