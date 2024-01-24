extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_green_changed():
	text = "Number of Green squares: %s" % Global.green

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
