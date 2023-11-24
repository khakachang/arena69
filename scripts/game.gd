extends Node2D
var rg = RandomNumberGenerator.new()

var enemy_1_scene = load("res://scenes/enemy_1.tscn")
var enemy_2_scene = load("res://scenes/enemy_2.tscn")
var enemy_3_scene = load("res://scenes/enemy_3.tscn")
var enemy_4_scene = load("res://scenes/enemy_4.tscn")

var enemy_no := 0
var enemies = []
func _process(delta):
	
	
	#Spawning enemies
	if $"enemy_spawn_time".is_stopped():
		enemy_no = rg.randi_range(1,4)
		var spawn_location = Vector2(rg.randf_range(-2448,2449), rg.randf_range(-2448,2449))
		print(enemy_no)
		if enemy_no == 1:
			var enemy = enemy_1_scene.instantiate()
			enemy.position = spawn_location
			add_child(enemy)
			enemies.append(enemy)
		if enemy_no == 2:
			var enemy = enemy_2_scene.instantiate()
			enemy.position = spawn_location
			add_child(enemy)
			enemies.append(enemy)
		if enemy_no == 3:
			var enemy = enemy_3_scene.instantiate()
			enemy.position = spawn_location
			add_child(enemy)
			enemies.append(enemy)
		if enemy_no == 4:
			var enemy = enemy_4_scene.instantiate()
			enemy.position = spawn_location
			add_child(enemy)
			enemies.append(enemy)
		
		$"enemy_spawn_time".start()
