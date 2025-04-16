extends Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Player = get_tree().current_scene.get_node("Player")
	Player.Change.connect(self_modulatey)

func self_modulatey(changeNum):
	if(changeNum == 0):
		modulate = Color8(255, 255, 255)
	elif (changeNum == 1):
		modulate = Color8(80, 80, 80)
	else:
		modulate = Color8(80, 80, 80)
