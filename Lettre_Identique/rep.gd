extends Button
var lettre
signal send_letter(letter)

# Called when the node enters the scene tree for the first time.
func _ready():
	var but_num = Main.curr_but
	Main.curr_but += 1
	lettre = Main.list_boutons[but_num]
	text = lettre

func _restart():
	var but_num = Main.curr_but
	Main.curr_but += 1
	lettre = Main.list_boutons[but_num]
	text = lettre


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_button_down():
	if lettre == Main.lettre_recherche:
		get_tree().call_group("etat", "_show_win")
		print("Bravo")
	else:
		get_tree().call_group("etat", "_show_loss")
		print("Non")
