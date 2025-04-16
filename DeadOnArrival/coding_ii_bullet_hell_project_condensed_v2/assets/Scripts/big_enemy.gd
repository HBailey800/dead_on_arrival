extends CharacterBody2D

var speed: int
var health: int
var shoots: bool
var motion = Vector2()
var bullet_speed = 200
var shootTimer = 100
var smallTimer = 0
var bullet = preload("res://assets//Scenes//enemy_bullet.tscn")
@onready
var shootPoint = $ShootPoint

func on_game_over():
	queue_free()

func _ready():
	var Player = get_tree().current_scene.get_node("Player")
	var Root = get_tree().current_scene
	Root.gameOver.connect(on_game_over)
	speed = self.get_meta("speed")
	health = self.get_meta("health")
	shoots = self.get_meta("firesProjectile")
	




func _physics_process(delta):
	if(smallTimer < shootTimer && shoots == true):
		smallTimer += 1
	elif (shoots == true):
		smallTimer = 0
		fire()
	
	if(get_tree().current_scene.get_node("Player") != null):
		var Player = get_tree().current_scene.get_node("Player")
		if(Player != null):
			position += (Player.global_position - global_position)/speed
			look_at(Player.global_position)
			move_and_collide(motion)
	


func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = shootPoint.global_position#get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(rotation)
	get_tree().get_root().call_deferred("add_child", bullet_instance)






func _on_enemy_area_entered(area: Area2D) -> void:
	if("Bullet" in area.name):
		if (health > 1):
			health = health - 1
		else:
			queue_free()
	elif("Death" in area.name):
		var rng = RandomNumberGenerator.new()
		rng.randomize() # Ensure different results each time
		var random_number = rng.randi_range(-500, 500)
		var random_number2 = rng.randi_range(-500, 500)
		global_position = Vector2(random_number, random_number2)
