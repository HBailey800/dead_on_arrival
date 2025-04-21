extends CharacterBody2D

var speed: int
var health: int
var shoots: bool
var motion = Vector2()
var bullet_speed = 500
var shootTimer = 50
var smallTimer = 0
var spawnTimer = 0
var bullet = preload("res://assets//Scenes//boss_enemy_shot.tscn")
var enemy = preload("res://assets//Scenes//enemy.tscn")
var shotNum = true
signal IsDead
@onready
var shootPoint = $ShootPoint
@onready
var point1 = $ShootPoint2
@onready
var point2 = $ShootPoint2

func on_game_over():
	queue_free()

func _ready():
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
		spawnTimer += 1
		if(shotNum == true):
			fire()
		else:
			fire2()

	if(spawnTimer == 7):
		Spawn()
		spawnTimer = 0
		
	
	if(get_tree().current_scene.get_node("Player") != null):
		var Player = get_tree().current_scene.get_node("Player")
		if(Player != null):
			position += (Player.global_position - global_position)/speed
			look_at(Player.global_position)
			move_and_collide(motion)
	


func fire():
	var i = 0
	while (i < 8):
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = shootPoint.global_position#get_global_position()
		if(i == 0):
			bullet_instance.rotation_degrees = rotation_degrees - 5
		elif(i == 1):
			bullet_instance.rotation_degrees = rotation_degrees + 5
		elif(i == 2):
			bullet_instance.rotation_degrees = rotation_degrees - 15
		elif(i == 3):
			bullet_instance.rotation_degrees = rotation_degrees + 15
		elif(i == 4):
			bullet_instance.rotation_degrees = rotation_degrees - 25
		elif(i == 5):
			bullet_instance.rotation_degrees = rotation_degrees + 25
		elif(i == 6):
			bullet_instance.rotation_degrees = rotation_degrees - 35
		elif(i == 7):
			bullet_instance.rotation_degrees = rotation_degrees + 35
			shotNum = false
		#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(bullet_instance.rotation)
		get_tree().get_root().call_deferred("add_child", bullet_instance)
		i = i + 1


func fire2():
	var i = 0
	while (i < 9):
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = shootPoint.global_position#get_global_position()
		if(i == 0):
			bullet_instance.rotation_degrees = rotation_degrees
		elif(i == 1):
			bullet_instance.rotation_degrees = rotation_degrees + 20
		elif(i == 2):
			bullet_instance.rotation_degrees = rotation_degrees - 20
		elif(i == 3):
			bullet_instance.rotation_degrees = rotation_degrees + 40
		elif(i == 4):
			bullet_instance.rotation_degrees = rotation_degrees - 40
		elif(i == 5):
			bullet_instance.rotation_degrees = rotation_degrees + 30
		elif(i == 6):
			bullet_instance.rotation_degrees = rotation_degrees - 30
		elif(i == 7):
			bullet_instance.rotation_degrees = rotation_degrees +10
		elif(i == 8):
			bullet_instance.rotation_degrees = rotation_degrees - 10
			shotNum = true
		#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(bullet_instance.rotation)
		get_tree().get_root().call_deferred("add_child", bullet_instance)
		i = i + 1

func Spawn():
	var enemy_instance 
		
	enemy_instance = enemy.instantiate()
	
	enemy_instance.position = point1.global_position
	get_tree().get_root().call_deferred("add_child", enemy_instance)
	
	enemy_instance = enemy.instantiate()
	
	enemy_instance.position = point2.global_position
	get_tree().get_root().call_deferred("add_child", enemy_instance)
		

func _on_enemy_area_entered(area: Area2D) -> void:
	if("Bullet" in area.name):
		if (health > 1):
			health = health - 1
		else:
			emit_signal("IsDead")
			queue_free()
