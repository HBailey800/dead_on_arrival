extends Sprite2D

var num = 2
# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Player = get_tree().current_scene.get_node("Player")
	Player.isHurt.connect(self_modulatex)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func self_modulatex():
	if(num == 2):
		modulate = Color(255,255,0)
	elif(num == 1):
		modulate = Color(255,0,0)
	else:
		modulate = Color(0,0,0)
	num -= 1
