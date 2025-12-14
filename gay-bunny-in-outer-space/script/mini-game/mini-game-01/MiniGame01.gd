extends MiniGame

@export var spawn_speed:float = 0.5
@export var survived_steps_to_win:int = 20

### Better to make a array of dic because FruitPosition says what array it is
@onready var apples: Dictionary = {
	FruitPosition.TOP: $MainGame/Apple/Top,
	FruitPosition.MIDDLE: $MainGame/Apple/Middle,
	FruitPosition.BOTTOM: $MainGame/Apple/Bottom
}

@onready var bananas: Dictionary = {
	FruitPosition.TOP: $MainGame/Banana/Top,
	FruitPosition.MIDDLE: $MainGame/Banana/Middle,
	FruitPosition.BOTTOM: $MainGame/Banana/Bottom
}

@onready var cherrys: Dictionary = {
	FruitPosition.TOP: $MainGame/Cherry/Top,
	FruitPosition.MIDDLE: $MainGame/Cherry/Middle,
	FruitPosition.BOTTOM: $MainGame/Cherry/Bottom
}

@onready var characters: Dictionary = {
	Position.LEFT: $MainGame/Charakter/Charakter_left,
	Position.MIDDLE: $MainGame/Charakter/Charakter_middle,
	Position.RIGHT: $MainGame/Charakter/Charakter_right
}

var survive_step: int = 0
var start_game:bool = false
var time_passed:float = 0.0
var skip_spawn:bool = false

var left_arrow_hover: bool = false
var right_arrow_hover: bool = false 

enum Position {LEFT, MIDDLE, RIGHT}
enum Fruit {APPLE, BANANA, CHERRY}
enum FruitPosition {TOP, MIDDLE, BOTTOM}

var char_pos: Position = Position.MIDDLE

func _ready() -> void:
	hide_all_charakters()
	characters[char_pos].visible = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !start_game: return
	
	time_passed += delta
	updated_visibility_bottom_line()
	check_game_over()
	
	if time_passed > spawn_speed:
		
		# moves fruits next & spawn next
		move_next_row()
		
		skip_spawn = !skip_spawn
		if !skip_spawn: spawn_random_fruit_at_top()
		
		# add succeeded steps
		survive_step += 1
		
		if survive_step >= survived_steps_to_win:
			mini_game_finished.emit()
			start_game = false
		
		time_passed = 0.0

func check_game_over() -> void:
	if char_pos == Position.LEFT and apples[FruitPosition.BOTTOM].frame == 1:
		game_over()
	elif char_pos == Position.MIDDLE and bananas[FruitPosition.BOTTOM].frame == 1:
		game_over()
	elif char_pos == Position.RIGHT and cherrys[FruitPosition.BOTTOM].frame == 1:
		game_over()

func game_over() -> void:
	$MainGame.hide()
	$CanvasLayer/StartScreen/Top/Label.text = "GAME OVER"
	$CanvasLayer/StartScreen.show()
	
	reset_game()
	

func reset_game() -> void:
	start_game = false
	time_passed = 0.0
	survive_step = 0
	
	hide_all_charakters()
	$MainGame/Charakter/Charakter_middle.show()
	char_pos = Position.MIDDLE
	
	# bad making sry
	for pos:int in apples:
		apples[pos].frame = 0
	for pos:int in bananas:
		bananas[pos].frame = 0
	for pos:int in cherrys:
		cherrys[pos].frame = 0

func move_next_row() -> void:
	move_fruits(apples)
	move_fruits(bananas)
	move_fruits(cherrys)

func move_fruits(fruits:Dictionary) -> void:
	var next: int = 0
	
	for fruit_pos:FruitPosition in fruits.keys():
		if fruits[fruit_pos].frame == 1:
			fruits[fruit_pos].frame = 0
			next += 1
		elif next > 0:
			fruits[fruit_pos].frame = 1
			next = 0
		

func spawn_random_fruit_at_top() -> void:
	var random_position : int = randi() % 3
	
	if random_position == Fruit.APPLE: spawn_fruit(apples)
	elif random_position == Fruit.BANANA: spawn_fruit(bananas)
	elif random_position == Fruit.CHERRY: spawn_fruit(cherrys)

func spawn_fruit(fruit:Dictionary) -> void:
	fruit[FruitPosition.TOP].frame = 1

# direction -1 => left | +1 => right
func update_position(direction: int) -> void:
	if char_pos == Position.LEFT and direction > 0:
		char_pos = Position.MIDDLE
	elif char_pos == Position.MIDDLE:
		if direction < 0:
			char_pos = Position.LEFT
		else:
			char_pos = Position.RIGHT
	elif char_pos == Position.RIGHT and direction < 0:
		char_pos = Position.MIDDLE
	
	hide_all_charakters()
	characters[char_pos].visible = true
	

func updated_visibility_bottom_line() -> void:
	update_column($MainGame/Apple/Bottom)
	update_column($MainGame/Banana/Bottom)
	update_column($MainGame/Cherry/Bottom)
	

func update_column(sprite: Sprite2D) -> void:
	if sprite.frame == 1: sprite.show() 
	else: sprite.hide()

func hide_all_charakters() -> void:
	$MainGame/Charakter/Charakter_left.hide();
	$MainGame/Charakter/Charakter_middle.hide();
	$MainGame/Charakter/Charakter_right.hide();

func _on_arrow_left_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and left_arrow_hover and event.is_released():
		# move charakter left
		update_position(-1)

func _on_arrow_left_mouse_entered() -> void:
	left_arrow_hover = true

func _on_arrow_left_mouse_exited() -> void:
	left_arrow_hover = false


func _on_arrow_right_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and right_arrow_hover and event.is_released():
		# move charakter right
		update_position(1)

func _on_arrow_right_mouse_entered() -> void:
	right_arrow_hover = true

func _on_arrow_right_mouse_exited() -> void:
	right_arrow_hover = false


func _on_button_button_up() -> void:
	# hide ui
	$CanvasLayer/StartScreen.hide()
	$MainGame.show()
	
	# start game
	start_game = true
