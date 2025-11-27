extends Camera2D

var shake_intensity: float = 0.0
var shake_decay: float = 3.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("camera")

func shake(power):
	shake_intensity = power

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake_intensity > 0:
		offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		shake_intensity = lerp(shake_intensity, 0.0, shake_decay * delta)
	else:
		offset = Vector2.ZERO
