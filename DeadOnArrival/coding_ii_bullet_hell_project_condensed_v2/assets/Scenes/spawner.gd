extends Node2D
var enemy = preload("res://assets//Scenes//enemy.tscn")
var big_enemy = preload("res://assets//Scenes//big_enemy.tscn")
var rangedEnemy = preload("res://assets//Scenes//rangedEnemy.tscn")
var boss1 = preload("res://assets//Scenes//boss_1.tscn")
var boss2 = preload("res://assets//Scenes//boss_2.tscn")
var boss3 = preload("res://assets//Scenes//boss_3.tscn")
var countdownTimer = 1.5
var enemyNum = 1
var roundNum = 0
@onready
var Point1 = $Point1
@onready
var Point2 = $Point2
@onready
var Point3 = $Point3
@onready
var Point4 = $Point4
@onready
var Point5 = $Point5
@onready
var Point6 = $Point6
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Player = get_tree().current_scene.get_node("Player")
	Player.isDead.connect(on_game_over)
	Countdown()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_game_over():
	queue_free()

func Countdown():
	var i = 0
	while i < enemyNum:
		var rng = RandomNumberGenerator.new()
		rng.randomize() # Ensure different results each time
		var random_number = rng.randi_range(0, 20)
		rng.randomize()
		var positionPoint = rng.randi_range(1, 6)
		var enemy_instance 
		
		if(random_number < 10):
			enemy_instance = enemy.instantiate()
		elif(random_number < 15):
			enemy_instance = big_enemy.instantiate()
		else:
			enemy_instance = rangedEnemy.instantiate()
		
		if(positionPoint == 1):
			enemy_instance.position = Point1.global_position
		elif(positionPoint == 2):
			enemy_instance.position = Point2.global_position
		elif(positionPoint == 3):
			enemy_instance.position = Point3.global_position
		elif(positionPoint == 4):
			enemy_instance.position = Point4.global_position
		elif(positionPoint == 5):
			enemy_instance.position = Point5.global_position
		elif(positionPoint == 6):
			enemy_instance.position = Point6.global_position
		get_tree().get_root().call_deferred("add_child", enemy_instance)
		i += 1
	await get_tree().create_timer(countdownTimer).timeout
	countdownTimer = countdownTimer - 0.1
	if(countdownTimer <= 0.2):
		countdownTimer = 1
		roundNum += 1
		if(roundNum == 3 and enemyNum != 0):
			enemyNum += 1
			roundNum = 0
	if(enemyNum == 4):
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var boss = rng.randi_range(1, 3)
		print(str(boss))
		var enemy_instance
		if(boss == 1):
			enemy_instance = boss1.instantiate()
			enemyNum = 0
		elif(boss == 2):
			enemy_instance = boss2.instantiate()
			enemyNum = 0
		elif(boss == 3):
			enemy_instance = boss3.instantiate()
			enemyNum = 0
		enemy_instance.global_position = Vector2(0, 0)
		get_tree().get_root().call_deferred("add_child", enemy_instance)
		enemy_instance.IsDead.connect(killPlayer)
		
	print("EnemyNum is - " + str(enemyNum))
	Countdown()

func killPlayer():
	await get_tree().create_timer(2).timeout
	var Player = get_tree().current_scene.get_node("Player")
	Player.call_deferred("kill")
