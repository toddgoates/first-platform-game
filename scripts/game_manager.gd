extends Node

var coins = 0

func add_coin():
	coins += 1
	var coin_label = get_tree().root.get_node("level1/CanvasLayer/CoinCounter")
	coin_label.text = "COINS: " + str(coins)
	print(coins)
