extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var start_button = Button.new()
	start_button.text = "start"
	start_button.pressed.connect(_on_pressed)
	get_node("start_container").add_child(start_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	pass

var level_0 = "res://assets//Scenes//hospital_four.tscn"
var level_1 = "res://assets//Scenes//hospital_one.tscn"
var level_2 = "res://assets//Scenes//hospital_two.tscn"
var level_3 = "res://assets//Scenes//hospital_three.tscn"

func add_scene(level):
	get_tree().change_scene_to_file(str(level))

func _on_pressed() -> void:
	var rand_lev = randi_range(0,3)
	if rand_lev == 0:
		add_scene(level_0)
		print("level 0")
	elif rand_lev == 1:
		add_scene(level_1)
		print("level 1")
	elif rand_lev == 2:
		add_scene(level_2)
		print("level 2")
	elif rand_lev == 3:
		add_scene(level_3)
		print("level 3")
