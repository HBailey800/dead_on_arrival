extends Sprite2D

var OutorNot = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Player = get_tree().current_scene.get_node("Player")
	Player.isOutofThrower.connect(self_modulatex)
	Player.Change.connect(self_modulatey)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func self_modulatex():
	if(OutorNot == false):
		modulate = Color8(0, 0, 0)
		OutorNot = true
	else:
		modulate = Color8(80, 80, 80)
		OutorNot = false

func self_modulatey(changeNum):
	if(OutorNot == false):
		if(changeNum == 1):
			modulate = Color8(80, 80, 80)
		elif (changeNum == 2):
			modulate = Color8(255, 255, 255)
		else:
			modulate = Color8(80, 80, 80)
