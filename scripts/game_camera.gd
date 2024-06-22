extends Camera3D

const SETTLE_POSITION = Vector3(0, 1.775, 5.488)
const SHAKE_LEN_TIME : float = 0.1
var shake_count = 0
var shake_total = 0
var shake_dist : float = 0.0
var shake_len : float = SHAKE_LEN_TIME

func _process(delta: float) -> void:
	shake_len = max(shake_len - delta, 0)
	v_offset = shake_dist * (float(shake_count)/max(shake_total, 1)) * (-1 if shake_count % 2 == 0 else 1)
	shake_len = SHAKE_LEN_TIME
	shake_count = max(shake_count - 1, 0)


func shake(amount, force):
	shake_count = amount
	shake_total = amount
	shake_dist = force


func _on_player_player_hurt() -> void:
	shake(randi_range(5, 20), randf_range(0.5, 3.0))
