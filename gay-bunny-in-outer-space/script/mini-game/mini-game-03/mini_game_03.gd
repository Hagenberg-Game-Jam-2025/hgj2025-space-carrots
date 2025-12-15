extends MiniGame

var color_rect_offset: Vector2 = Vector2(50,50)
var is_grabbing: bool = false
var connected_cable: int = 0
const max_count_cable: int = 4

var selected_area: Area2D
var saved_area: Area2D
var line: Line2D

@export var colors: Array[Color] = [
	Color(0.0, 0.525, 1.0), 
	Color(1.0, 0.204, 0.424), 
	Color(0.847, 0.388, 1.0), 
	Color(0.529, 0.69, 0.0)
]

func _ready() -> void:
	_connect_mouse_entered($"Left Side".get_children())
	_connect_mouse_entered($"Right Side".get_children())
	
	generate_random_colors($"Left Side".get_children())
	generate_random_colors($"Right Side".get_children())

func _process(delta: float) -> void:
	if line and is_grabbing:
		line.set_point_position(1, get_global_mouse_position())
	
func _connect_mouse_entered(children: Array[Node]) -> void:
	for area:Area2D in children:
		area.mouse_entered.connect(_on_mouse_entered.bind(area))
		area.mouse_exited.connect(_on_mouse_exited)

func generate_random_colors(children: Array[Node]) -> void:
	# copy array color
	var available_colors:Array[Color] = colors.duplicate()
	available_colors.shuffle()
	
	for child:Node in children:
		if child is Area2D:
			var area2d: Area2D = child
			set_color_of_area(area2d, available_colors.pop_front())

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and selected_area:
			grabbing()
		elif event.is_released() and selected_area:
			drop_inside()
		elif event.is_released():
			drop()

func grabbing() -> void:
	is_grabbing = true
	saved_area = selected_area
	
	# create line
	line = Line2D.new()
	
	line.add_point(selected_area.position)
	line.add_point(get_global_mouse_position())
	line.default_color = get_color_of_area(selected_area)
	line.width = 100
	
	$Lines.add_child(line)

func drop_inside() -> void:
	if selected_area == saved_area or get_color_of_area(selected_area) != get_color_of_area(saved_area):
		# wrong placement => drop
		drop()
	else:
		# right placement => save it
		is_grabbing = false
		saved_area = null
		line = null
		
		connected_cable += 1
		if connected_cable >= max_count_cable:
			mini_game_finished.emit()
	

func drop() -> void:
	is_grabbing = false
	saved_area = null
	
	$Lines.remove_child(line)
	line = null

func get_color_of_area(area:Area2D) -> Color:
	if !area: return Color.WHITE
	for child:Node in area.get_children():
		if child is Sprite2D:
			var sprite:Sprite2D = child
			return sprite.modulate
	return Color.WHITE

func set_color_of_area(area:Area2D, color:Color) -> void:
	if !area: return
	for child:Node in area.get_children():
		if child is Sprite2D:
			var sprite:Sprite2D = child
			sprite.modulate = color

func _on_mouse_entered(area:Area2D) -> void:
	selected_area = area

func _on_mouse_exited() -> void:
	selected_area = null
