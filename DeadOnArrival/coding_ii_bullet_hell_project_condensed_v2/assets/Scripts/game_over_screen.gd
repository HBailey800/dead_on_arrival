extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var restartbutton = Button.new()
	restartbutton.text = "restart"
	restartbutton.pressed.connect(_restart)
	get_node("rs_q_button_container").add_child(restartbutton)
	var quitbutton = Button.new()
	quitbutton.text = "quit"
	quitbutton.pressed.connect(_quit)
	get_node("rs_q_button_container").add_child(quitbutton)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _restart():
	get_tree().change_scene_to_file("res://assets//Scenes//start_screen.tscn")
	print("game reset")

func _quit():
	get_tree().quit()
	print("game over")
