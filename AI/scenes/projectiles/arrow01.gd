extends CharacterBody2D

@export var speed = 300

#@onready var velocity = Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var collision_info = move_and_collide(velocity.normalized() *speed * delta)
	if collision_info: 
		
		if not collision_info.get_collider().is_in_group('player'):
			collision_info.get_collider().queue_free()
		queue_free()
