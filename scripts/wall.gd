extends TileMap

@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("required_coins_reached", Callable(self, "_on_items_reached"))

func _on_items_reached():
	explosion_sound.play()
	
	for cam in get_tree().get_nodes_in_group("camera"):
		cam.shake(4)
	
	await explosion_sound.finished
	queue_free()
