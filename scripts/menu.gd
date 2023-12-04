extends Node2D


func _ready():
	$"CanvasLayer/shopContainer".visible = false
	$"music".play()
	var playerConfig = ConfigFile.new()
	var test = playerConfig.load("user://PlayerData.cfg")
	if test != OK:
		playerConfig.set_value("PlayerData", "player", 1)
		playerConfig.save("user://PlayerData.cfg")
	if test == OK:
		if playerConfig.get_value("PlayerData", "player") == 1:
			$"player".sprite_frames = load("res://looby_player/player1.tres")
		if playerConfig.get_value("PlayerData", "player") == 2:
			$"player".sprite_frames = load("res://looby_player/player2.tres")
		if playerConfig.get_value("PlayerData", "player") == 3:
			$"player".sprite_frames = load("res://looby_player/player3.tres")
		if playerConfig.get_value("PlayerData", "player") == 4:
			$"player".sprite_frames = load("res://looby_player/player4.tres")
	#$"background".scale = get_viewport_rect().size
	$"player".play("idle")
	#$"bg".scale = get_viewport_rect().size
	var config = ConfigFile.new()
	var err = config.load("user://GameData.cfg")
	
	if err != OK:
		return
	$"CanvasLayer/gem_indicator".text = str(config.get_value("GameData","gems"))
	$"CanvasLayer/shopContainer".visible = false

func _on_play_button_pressed():
	
	get_tree().change_scene_to_file("res://scenes/game_load_screen.tscn")


func _on_shop_button_pressed():
	$"click_sound".play()
	$"CanvasLayer/shopContainer".visible = !$"CanvasLayer/shopContainer".visible


func _on_close_pressed():
	$"click_sound".play()
	$"CanvasLayer/shopContainer".visible = false


func _on_purchase_p_1_pressed():
	$"click_sound".play()
	$"player".sprite_frames = load("res://looby_player/player1.tres")
	$"player".play("idle")
	var config = ConfigFile.new()
	config.set_value("PlayerData", "player", 1)
	config.save("user://PlayerData.cfg")
func _on_purchase_p_2_pressed():
	$"click_sound".play()
	$"player".sprite_frames = load("res://looby_player/player2.tres")
	$"player".play("idle")
	var config = ConfigFile.new()
	config.set_value("PlayerData", "player", 2)
	config.save("user://PlayerData.cfg")

func _on_purchase_p_3_pressed():
	$"click_sound".play()
	$"player".sprite_frames = load("res://looby_player/player3.tres")
	$"player".play("idle")
	var config = ConfigFile.new()
	config.set_value("PlayerData", "player", 3)
	config.save("user://PlayerData.cfg")

func _on_purchase_p_4_pressed():
	$"click_sound".play()
	$"player".sprite_frames = load("res://looby_player/player4.tres")
	$"player".play("idle")
	var config = ConfigFile.new()
	config.set_value("PlayerData", "player", 4)
	config.save("user://PlayerData.cfg")
