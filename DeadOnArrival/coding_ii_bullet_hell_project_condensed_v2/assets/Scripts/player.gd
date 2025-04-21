extends CharacterBody2D

var movespeed = 500
var bullet_speed = 2000
var shotgun_ammo = 10
var thrower_ammo = 100
var playerHealth = 3
var bullet = preload("res://assets//Scenes//Bullet.tscn")
var flamebullet = preload("res://assets//Scenes//Flame_Bullet.tscn")
var shot = "gun"
var canbehurt = true
var changeNum = 0
signal isDead
signal isOutofShotgun
signal isOutofThrower
signal isHurt
signal Change(changeNum)
@onready
var shootPoint = $ShootPoint

func _ready():
	set_process(true)
	$"../Camera2D/pause_menu_main".set_visible(false)


func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().paused = true
		$"../Camera2D/pause_menu_main".set_visible(true)
		print("paused")

func _physics_process(delta):
	var motion = Vector2()
	
	if (Input.is_action_pressed("Up")):
		motion.y -= 1
	if (Input.is_action_pressed("Down")):
		motion.y += 1
	if (Input.is_action_pressed("Left")):
		motion.x -= 1
	if (Input.is_action_pressed("Right")):
		motion.x += 1
	
	motion = motion.normalized()
	velocity = motion * movespeed
	move_and_slide()
	motion = velocity
	
	look_at(get_global_mouse_position())
	if (Input.is_action_just_pressed("LMB")):
		if(shot == "gun"):
			gun_fire()
		elif (shot == "shotgun"):
			shotgun_fire()
	if(Input.is_action_pressed("LMB")):
		if (shot == "flame"):
			flamethrower_fire()
	if(Input.is_action_just_pressed('Change')):
		change()

func change():
	if(shot == "gun"):
		shot = "shotgun"
		changeNum = 1
	elif(shot == "shotgun"):
		shot = "flame"
		changeNum = 2
	elif(shot == "flame"):
		shot = "gun"
		changeNum = 0
	emit_signal("Change", changeNum)


func gun_fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = shootPoint.global_position#get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(rotation)
	get_tree().get_root().call_deferred("add_child", bullet_instance)

func shotgun_fire():
	if(shotgun_ammo > 0):
		var i = 0
		while (i < 5):
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
			#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
			bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(bullet_instance.rotation)
			get_tree().get_root().call_deferred("add_child", bullet_instance)
			i = i + 1
		shotgun_ammo -= 1
		if(shotgun_ammo <= 0):
			shotgun_reload()

func flamethrower_fire():
	if(thrower_ammo > 0):
		var bullet_instance = flamebullet.instantiate()
		bullet_instance.position = shootPoint.global_position#get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		bullet_instance.linear_velocity = Vector2(bullet_speed,0).rotated(rotation)
		get_tree().get_root().call_deferred("add_child", bullet_instance)
		thrower_ammo -= 1
		if(thrower_ammo <= 0):
			thrower_reload()

func shotgun_reload():
	emit_signal("isOutofShotgun")
	await get_tree().create_timer(10.0).timeout
	emit_signal("isOutofShotgun")
	shotgun_ammo = 10

func thrower_reload():
	emit_signal("isOutofThrower")
	await get_tree().create_timer(15.0).timeout
	emit_signal("isOutofThrower")
	thrower_ammo = 100

func kill():
	emit_signal("isDead")

func canBeHurt():
	await get_tree().create_timer(1.0).timeout
	canbehurt = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if("Enemy" in area.name or "EnemyShot" in area.name):
		if(playerHealth > 0 && canbehurt):
			playerHealth -= 1
			emit_signal("isHurt")
			canbehurt = false
			canBeHurt()
		elif (canbehurt):
			call_deferred("kill")
