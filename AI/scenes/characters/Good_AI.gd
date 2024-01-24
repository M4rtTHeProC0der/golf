extends CharacterBody2D

@export var MAX_SPEED = 300
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var selfPath = load('res://scenes/characters/Good_AI.tscn')

@onready var axis = Vector2.ZERO

signal green_changed()

func _ready():
	#speed(MAX_SPEED + randi_range(-40, 40))
	#fric(FRICTION / (1.5- randf()))
	#accel(ACCELERATION + randi_range(-40, 40))
	print(str(MAX_SPEED)+ " " +str(FRICTION) + " " + str (ACCELERATION))
	print("%s is the tree" % get_tree())
	print_tree()
	get_tree().call_group("green_label","_on_green_changed")
func _init():
	
	Global.green += 1

	emit_signal("green_changed")

func speed(mAX_SPEED):
	MAX_SPEED = mAX_SPEED
func accel(aCCELERATION):
	ACCELERATION = aCCELERATION
func fric(fRICTION):
	FRICTION = fRICTION

func _physics_process(delta):

	var coll_info = move(delta)
	if coll_info:

		if coll_info.get_collider().is_in_group('green'):

			baby()
		
	
	
		
		
	

func get_input_axis():
	axis.x = randi_range(0,1) - randi_range(0,1)
	axis.y = randi_range(0,1) - randi_range(0,1)
	return axis.normalized()
func _notification(what):
	match what:
		NOTIFICATION_PREDELETE:
			on_predelete()
func on_predelete():
	Global.green -= 1
	print(Global.green)
	get_tree().call_group("green_label","_on_green_changed")
	emit_signal("green_changed")
	print('Dying')

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

func baby():
	if Global.green != Global.green_limit:
		var baby = selfPath.instantiate()
		
		get_parent().add_child(baby)
		
		
		baby.position = $Marker2D.global_position
		baby.MAX_SPEED = MAX_SPEED + randi_range(-45,450)
		baby.ACCELERATION = ACCELERATION + randi_range(-45,45)
		baby.FRICTION = FRICTION / (1.5 - randf())
		print(baby.MAX_SPEED)

