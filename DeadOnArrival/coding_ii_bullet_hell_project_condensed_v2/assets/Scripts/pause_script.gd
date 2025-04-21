extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var unpausebutton = Button.new()
	unpausebutton.text = "Resume"
	unpausebutton.pressed.connect(_unpause)
	get_node("pause_menu_container").add_child(unpausebutton)
	
	var quittomenu_button = Button.new()
	quittomenu_button.text = "Exit to Title Menu"
	quittomenu_button.pressed.connect(_quit_game)
	get_node("pause_menu_container").add_child(quittomenu_button)
	
	var quitbutton = Button.new()
	quitbutton.text = "Exit to Desktop"
	quitbutton.pressed.connect(_quit_to_menu)
	get_node("pause_menu_container").add_child(quitbutton)


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _unpause():
	get_tree().paused = false
	
	print("unpaused")

func _quit_game():
	get_tree().change_scene_to_file("res://assets/Scenes/start_screen.tscn")

func _quit_to_menu():
	get_tree().quit()
