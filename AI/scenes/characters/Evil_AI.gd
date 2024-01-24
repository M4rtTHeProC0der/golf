extends CharacterBody2D

@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO
@onready var random = RandomNumberGenerator.new()
func _physics_process(delta):
	var coll_info = move(delta)
	if coll_info:
		if coll_info.get_collider().is_in_group('green'):
			coll_info.get_collider().queue_free()
	

func get_input_axis():
	axis.x = randi_range(0,1) - randi_range(0,1)
	axis.y = randi_range(0,1) - randi_range(0,1)
	return axis.normalized()
	
func move(delta):
	
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	return move_and_collide(velocity)
	
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
		
	else:
		velocity =  Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)
