extends Node2D

signal fired

var rg = RandomNumberGenerator.new()

var enemy_1_scene = load("res://scenes/enemy_1.tscn")
var enemy_2_scene = load("res://scenes/enemy_2.tscn")
var enemy_3_scene = load("res://scenes/enemy_3.tscn")
var enemy_4_scene = load("res://scenes/enemy_4.tscn")
var lettuce_scene = load("res://scenes/lettuce.tscn")

var desi_scene = load("res://scenes/desi_katta_dropeed.tscn")
var m4_scene = load("res://scenes/m_469_dropped.tscn")
var shotgun_scene = load("res://scenes/shotgun_dropped.tscn")

var enemy_no := 0
var enemies = []
var nearest_enemy : Object

var bullet_scene = load("res://scenes/bullet.tscn")
var kills = 0
var death = false
func _ready():
	$"msg/BoxContainer".visible = false
	$"enemy_spawn_time".wait_time = 3.5
	$"first_enemy_timer".start()
	
	var config = ConfigFile.new()
	var err = config.load("user://PlayerData.cfg")
	if err == OK:
		if config.get_value("PlayerData", "player") == 1:
			$"player/AnimatedSprite2D".sprite_frames = load("res://AnimtedSprite/player1.tres")
		if config.get_value("PlayerData", "player") == 2:
			$"player/AnimatedSprite2D".sprite_frames = load("res://AnimtedSprite/player2.tres")
		if config.get_value("PlayerData", "player") == 3:
			$"player/AnimatedSprite2D".sprite_frames = load("res://AnimtedSprite/player3.tres")
		if config.get_value("PlayerData", "player") == 4:
			$"player/AnimatedSprite2D".sprite_frames = load("res://AnimtedSprite/player4.tres")
func _process(delta):
	
	
	$"msg/Label".text = "Enemy spawning in " + str(round($"first_enemy_timer".time_left * 100) / 100)
	if death == false:
		
		var shortest_distance = float(INF)
		if $"player/healthbar".value != 0:
			for enemy in enemies:
				if enemy == null:
					if kills <= 5:
						var spawn_pos = $"player".position + Vector2(randf_range(-400,400),randf_range(-600,600))
						spawn_enemies(spawn_pos)
					enemies.erase(enemy)
					kills += 1
				if enemy != null:
					enemy.player_position = $"player".position
					
					var enemy_distance = $"player".position.distance_to(enemy.position)
					if enemy_distance < shortest_distance:
						shortest_distance = enemy_distance
						nearest_enemy = enemy
		
		if $"player/healthbar".value != 0:
			if nearest_enemy != null:
				if $"player".position.distance_to(nearest_enemy.position) < 300:
					$"player".current_gun.look_at(nearest_enemy.position)
					fired.emit()

				else:
					$"player".current_gun.rotation = $"player/Control/movement_jt".output.angle()
			if nearest_enemy == null:
				$"player".current_gun.rotation = $"player/Control/movement_jt".output.angle()
		
		
		if $"player/healthbar".value != 0:
			#spawing lettuce
			if $"lettuce_spawn_time".is_stopped() and $"first_enemy_timer".is_stopped():
				var lettuce_pos = Vector2(rg.randf_range(-2448,2449), rg.randf_range(-2448,2449))
				var lettuce = lettuce_scene.instantiate()
				lettuce.position = lettuce_pos
				add_child(lettuce)
				$"lettuce_spawn_time".start()
			#spawing gun
			if $"gun_spawn_time".is_stopped() and $"first_enemy_timer".is_stopped():
				var gun_to_spawn = rg.randi_range(1,3)
				if gun_to_spawn == 1:
					var gun_pos = Vector2(rg.randf_range(-2448,2449), rg.randf_range(-2448,2449))
					var gun = desi_scene.instantiate()
					gun.position = gun_pos
					add_child(gun)
					$"gun_spawn_time".start()
				if gun_to_spawn == 2:
					var gun_pos = Vector2(rg.randf_range(-2448,2449), rg.randf_range(-2448,2449))
					var gun = m4_scene.instantiate()
					gun.position = gun_pos
					add_child(gun)
					$"gun_spawn_time".start()
				if gun_to_spawn == 3:
					var gun_pos = Vector2(rg.randf_range(-2448,2449), rg.randf_range(-2448,2449))
					var gun = shotgun_scene.instantiate()
					gun.position = gun_pos
					add_child(gun)
					$"gun_spawn_time".start()
			#Spawning enemies
			if $"enemy_spawn_time".is_stopped() and $"first_enemy_timer".is_stopped():
				var spawn_pos = Vector2(rg.randf_range(-2448,2449), rg.randf_range(-2448,2449))
				spawn_enemies(spawn_pos)
		
		if $"player/healthbar".value == 0:
			#Saving gems data
			var gemsCount := 0
			var config = ConfigFile.new()
			var err = config.load("user://GameData.cfg")
			if err == OK:
				gemsCount = config.get_value("GameData","gems") + $"player".gems
			if err != OK:
				gemsCount = $"player".gems
			print(gemsCount)
			config.set_value("GameData", "gems", gemsCount)
			config.set_value("GameData", "kill", kills)
			config.set_value("GameData", "gemsCollected", $"player".gems)
			config.save("user://GameData.cfg")
			death = true
			$"player".queue_free()
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func spawn_enemies(spawn_location):
	enemy_no = rg.randi_range(1,4)
	#var spawn_location = Vector2(rg.randf_range(-2448,2449), rg.randf_range(-2448,2449))
	#var spawn_location = $"player".position + Vector2(randf_range(-400,400),randf_range(-600,600))
	if enemy_no == 1:
		var enemy = enemy_1_scene.instantiate()
		if kills >= 10:
			enemy.start_speed = 50
			enemy.end_speed = 100
		if kills >= 15:
			enemy.start_speed = 80
			enemy.end_speed = 120
		enemy.position = spawn_location
		add_child(enemy)
		enemies.append(enemy)
	if enemy_no == 2:
		var enemy = enemy_2_scene.instantiate()
		if kills >= 10:
			enemy.start_speed = 50
			enemy.end_speed = 100
		if kills >= 15:
			enemy.start_speed = 80
			enemy.end_speed = 120
		enemy.position = spawn_location
		add_child(enemy)
		enemies.append(enemy)
				
	if enemy_no == 4:
		var enemy = enemy_4_scene.instantiate()
		if kills >= 10:
			enemy.start_speed = 50
			enemy.end_speed = 100
		if kills >= 15:
			enemy.start_speed = 80
			enemy.end_speed = 120
		enemy.position = spawn_location
		add_child(enemy)
		enemies.append(enemy)
	if enemy_no == 3:
		var enemy = enemy_3_scene.instantiate()
		if kills >= 10:
			enemy.speed = 100
		if kills >= 15:
			enemy.speed = 120
		enemy.position = spawn_location
		add_child(enemy)
		enemies.append(enemy)
				
	if kills >= 5:
		$"enemy_spawn_time".wait_time = 2.5
	if kills >= 10:
		$"enemy_spawn_time".wait_time = 2
	$"enemy_spawn_time".start()
		


func _on_first_enemy_timer_timeout():
	var spawn_pos = $"player".position + Vector2(randf_range(-400,400),randf_range(-600,600))
	spawn_enemies(spawn_pos)
	$"msg/Label".visible = false





func _on_play_pressed():
	$"msg/pause".visible = true
	$"msg/BoxContainer".visible = false
	get_tree().paused = false

func _on_pause_pressed():
	$"msg/pause".visible = false
	$"msg/BoxContainer".visible = true
	get_tree().paused = true


func _on_save_and_exit_pressed():
	get_tree().paused = false
	#Saving gems data
	var gemsCount := 0
	var config = ConfigFile.new()
	var err = config.load("user://GameData.cfg")
	if err == OK:
		gemsCount = config.get_value("GameData","gems") + $"player".gems
	if err != OK:
		gemsCount = $"player".gems
	print(gemsCount)
	config.set_value("GameData", "gems", gemsCount)
	config.set_value("GameData", "kill", kills)
	config.set_value("GameData", "gemsCollected", $"player".gems)
	config.save("user://GameData.cfg")
	death = true
	$"player".queue_free()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
