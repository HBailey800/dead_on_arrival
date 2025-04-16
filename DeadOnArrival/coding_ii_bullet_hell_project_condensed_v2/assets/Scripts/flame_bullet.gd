extends RigidBody2D


func on_game_over():
	queue_free()

func _ready():
	var Root = get_tree().current_scene
	Root.gameOver.connect(on_game_over)
	await get_tree().create_timer(0.3).timeout
	queue_free()


func _on_bullet_area_entered(area: Area2D) -> void:
	if("Enemy" in area.name):
		await get_tree().create_timer(0.001).timeout
		queue_free()
	elif ("EnemyShot" in area.name):
		await get_tree().create_timer(0.001).timeout
		queue_free()
