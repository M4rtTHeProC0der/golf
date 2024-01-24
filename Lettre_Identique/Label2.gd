extends Label


# Called when the node enters the scene tree for the first time.
func _show_win():
	text = "Bravo!"
	await get_tree().create_timer(1).timeout
	text = ""
func _show_loss():
	text = "Mauvais"
	await get_tree().create_timer(1).timeout
	text = ""
