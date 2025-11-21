extends Control

func _on_restart_pressed() -> void:
	# Reset game state
	Engine.time_scale = 1.0
	Music.play()
	GameManager.lives = 3
	GameManager.coins = 0

	# Reload the first level
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
