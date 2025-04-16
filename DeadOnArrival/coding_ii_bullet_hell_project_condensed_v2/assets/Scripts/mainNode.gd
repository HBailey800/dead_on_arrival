extends Node2D

signal gameOver
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Player = get_tree().current_scene.get_node("Player")
	Player.isDead.connect(on_game_over)

func on_game_over():
	emit_signal("gameOver")
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://assets//Scenes/game_over_screen.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
