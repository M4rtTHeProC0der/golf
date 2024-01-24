extends TileMap
@onready var width = 72
@onready var heigth = 40
@onready var closed_tiles : Array = []
@onready var open_tiles = []
@onready var come_from : Dictionary = {}
@onready var path : Dictionary = {}
@onready var sScore : Dictionary = {}
@onready var eScore : Dictionary = {}
@onready var aScore : Dictionary = {}
@onready var start_position : Vector2i= local_to_map(to_local($start.global_position))
@onready var end_position : Vector2i= local_to_map(to_local($end.global_position))
@onready var diagonals : Array= [Vector2i(1,1), Vector2i(1,-1), Vector2i(-1,1),Vector2i(-1,-1)]
var current_tile : Vector2i

static func _index(x: int, y: int, _width: int) -> int:
	return int(y * _width + x)
static func _indexv(coord: Vector2i, _width: int) -> int:
	return int(coord.y * _width + coord.x)

static func _position(i: int, width: int) -> Vector2i:
	var y := int(i / float(width))
	var x := int(i - width * y)
	return Vector2i(x, y)
# Called when the node enters the scene tree for the first time.
func _ready():
	path[start_position] = []
	open_tiles = [start_position]
	current_tile = start_position
	
	

	
func _input(event):	
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))


			_set_clicked(pos_clicked)
func _close_tile(position: Vector2i):
	closed_tiles.append(position)
	aScore.erase(position)
	sScore.erase(position)
	eScore.erase(position)
	open_tiles.erase(position)
	if position != start_position:
		set_cell(0, position,0,Vector2i(4,0))

func _set_clicked(position: Vector2i):
	if current_tile != end_position and open_tiles.size() != 0:
		_close_tile(current_tile)
		_AS_neighbhor(current_tile)
		current_tile = _new_current()

	elif current_tile == end_position:
		alt_color_path()
	

#A function that takes two dictionaries, a main one and a second one and that 
#Ouptuts the second dictionary with the first one's minimums keys and the second's value
func min_to_next(Dict1 : Dictionary, Dict2 : Dictionary) -> Dictionary:

	var new_dict : Dictionary = {}
	var min : int = 1000000000

	for key in Dict1:
		var val = Dict1[key]
		if val < min:
			min = val
			new_dict = {}
		if val == min:
			new_dict[key] = Dict2[key]
	return new_dict


		
func _new_current() -> Vector2i:
	var curr_ascore : Array = aScore.values()
	var curr_escore = eScore.values()
	var curr_sscore = sScore.values()
	var new_current : Vector2i 
	#Verify which nodes have the lowest total score and make curr posses the escore of those

	var curr : Dictionary = min_to_next(aScore, eScore)

	#If there are more than one node with the lowest total heuristic::

	#Check for the nodes within those minimums which possess the lowest distance from the target
	curr = min_to_next(curr, sScore)

	var temp_min : int = 100000000
	for key in curr:
		if curr[key] < temp_min:
			temp_min = curr[key]
			new_current = key
	return new_current
		
		
		
func _get_surround(cell : Vector2i) -> Array:
	var surround : Array= []
	for diagonal : Vector2i in diagonals:
		surround.append(cell + diagonal)
	return surround + get_surrounding_cells(cell)
		
func xylenght(Vector : Vector2i) -> int:
	return abs(Vector.x) + abs(Vector.y)
func _check_size(list : Array):
	var size : float = 0.0
	for move : Vector2i in list:
		size += move.length()
	return size
func _AS_neighbhor(position : Vector2i):
	var surround : Array = get_surrounding_cells(position)
	var start_distance : int 
	var end_distance : int

	for cell : Vector2i in surround:

		if get_cell_atlas_coords(0, cell) == Vector2i(1,0) or cell in closed_tiles:
			continue
		if cell not in open_tiles:
			if cell != end_position:
				set_cell(0, cell,0,Vector2i(5,0))
			path[cell] = [position]
		if path[position].size() + 1 < path[cell].size() or cell not in open_tiles:
			path[cell] = path[position] + [position]
			come_from[cell] = position - cell
			start_distance = abs((cell - start_position).length())
			sScore[cell] = start_distance
			end_distance = abs((end_position - cell).length())
			eScore[cell] = end_distance
			aScore[cell] = end_distance + start_distance
			#print("the start cell is %s and the current cell is %s the vector to each other is %s" % 
			#[start_position, cell, start_position - cell])
			#print("The cell %s is the direction %s and is %s pixels apart from the beggining and %s
			 #apart from the end which is %s" % [cell, cell-position, start_distance, end_distance, end_position])
		#if cell not in open_tiles:
			open_tiles.append(cell)

	
func color_path():
	var curr_tile : Vector2i= current_tile
	while curr_tile != start_position:
		if get_cell_atlas_coords(0,curr_tile) != Vector2i(1,0):
			set_cell(0, curr_tile,0,Vector2i(6,0))
			curr_tile += come_from[curr_tile]
func alt_color_path():
	for cell in path[end_position]:
		if get_cell_atlas_coords(0,cell) != Vector2i(1,0):
			set_cell(0, cell,0,Vector2i(6,0))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_set_clicked(Vector2i.ZERO)
	
