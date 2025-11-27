extends Node

signal required_coins_reached

var coins = 0
var required_coins = 10
var lives := 3

func reset_coins():
	coins = 0

	var coin_label = get_tree().current_scene.get_node("HUD/CoinCounter")
	coin_label.text = "COINS: 0"

func add_coin():
	coins += 1
	var coin_label = get_tree().current_scene.get_node("HUD/CoinCounter")
	coin_label.text = "COINS: " + str(coins)
	
	if coins == required_coins:
		emit_signal("required_coins_reached")
	
func add_life():
	lives += 1
	
	var lives_label = get_tree().current_scene.get_node("HUD/LivesCounter")
	lives_label.text = "LIVES: " + str(lives)
	 
func lose_life():
	lives -= 1
	
	var lives_label = get_tree().current_scene.get_node("HUD/LivesCounter")
	lives_label.text = "LIVES: " + str(lives)
	
	if lives <= 0:
		Music.stop()
		game_over()
	else:
		reset_coins()

func game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
