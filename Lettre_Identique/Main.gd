extends Node


@onready var lettre_recherche = Lettre.get_random_letter()
@onready var list_boutons = [lettre_recherche, Lettre.get_random_letter_exclude(lettre_recherche), Lettre.get_random_letter_exclude(lettre_recherche)]
@onready var curr_but = 0

func _ready():
	randomize()
	list_boutons.shuffle()
func _restart():
	lettre_recherche = Lettre.get_random_letter()
	list_boutons = [lettre_recherche, Lettre.get_random_letter_exclude(lettre_recherche), Lettre.get_random_letter_exclude(lettre_recherche)]
	curr_but = 0
	randomize()
	list_boutons.shuffle()
	get_tree().call_group("game", "_restart")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
