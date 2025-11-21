extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoinCounter.text = "COINS: " + str(GameManager.coins)
	$LivesCounter.text = "LIVES: " + str(GameManager.lives)
