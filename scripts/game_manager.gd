extends Node

var coins = 0
var lives = 3

func add_coin():
	coins += 1
	var coin_label = get_tree().root.get_node("level1/HUD/CoinCounter")
	coin_label.text = "COINS: " + str(coins)
	print(coins)
	
func lose_life():
	print("YOU LOST A LIFE!")
	lives -= 1
	var lives_label = get_tree().root.get_node("level1/HUD/LivesCounter")
	lives_label.text = "LIVES: " + str(lives)
	
	if lives <= 0:
		lives_label.text = "GAME OVER!"
