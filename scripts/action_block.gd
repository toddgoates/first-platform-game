extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var relative_y = body.global_position.y - global_position.y

		if relative_y > 0:
			print("You hit the block")
			get_tree().change_scene_to_file("res://scenes/level_complete.tscn")
