extends RigidBody2D


func on_game_over():
	queue_free()

func _ready():
	var Player = get_tree().current_scene.get_node("Player")
	var Root = get_tree().current_scene
	Root.gameOver.connect(on_game_over)
	await get_tree().create_timer(5).timeout
	queue_free()

func _on_enemy_shot_area_entered(area: Area2D) -> void:
	if("Player" in area.name):
		await get_tree().create_timer(0.002).timeout
		queue_free()
	elif ("Bullet" in area.name):
		await get_tree().create_timer(0.001).timeout
		queue_free()
