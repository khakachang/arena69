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
		config.set_value("GameData", "gems", 0)
		config.save("user://GameData.cfg")
	if err == OK:
		$"CanvasLayer/gem_indicator".text = str(config.get_value("GameData","gems"))
		$"CanvasLayer/shopContainer".visible = false
	
	#Gun config
	var gunSettingConfig = ConfigFile.new()
	
	var gunConfigExist = gunSettingConfig.load("user://gunSetting.cfg")

	if gunConfigExist != OK:
		#desi_katta
		gunSettingConfig.set_value("Desi_Katta", "level", 1)
		gunSettingConfig.set_value("Desi_Katta", "damage", 0.8)
		gunSettingConfig.set_value("Desi_Katta", "fireRate", 0.1)
		gunSettingConfig.set_value("Desi_Katta", "reloadTime", 1)
		gunSettingConfig.set_value("Desi_Katta", "desi_price", 1)
		
		#m469
		gunSettingConfig.set_value("m469", "level", 1)
		gunSettingConfig.set_value("m469", "damage", 1.5)
		gunSettingConfig.set_value("m469", "fireRate", 0.2)
		gunSettingConfig.set_value("m469", "reloadTime", 1.5)
		gunSettingConfig.set_value("m469", "m469_price", 1)
		
		#shotgun
		gunSettingConfig.set_value("shotgun", "level",1)
		gunSettingConfig.set_value("shotgun", "damage", 3)
		gunSettingConfig.set_value("shotgun", "fireRate", 1)
		gunSettingConfig.set_value("shotgun", "reloadTime", 0.5)
		gunSettingConfig.set_value("shotgun", "shotgun_price", 1)
		#save
		gunSettingConfig.save("user://gunSetting.cfg")
	
		
func _process(delta):
	#Gems updating
	var gemConfig = ConfigFile.new()
	var gem_config_exist = gemConfig.load("user://GameData.cfg")
	if gem_config_exist == OK:
		$"CanvasLayer/gem_indicator".text = str(gemConfig.get_value("GameData","gems"))
	
	
	var gunSettingConfig = ConfigFile.new()
	var gunConfigExist = gunSettingConfig.load("user://gunSetting.cfg")
	if gunConfigExist == OK:
		#c_desi_katta_label
		var c_level = "Level " + str(gunSettingConfig.get_value("Desi_Katta", "level"))
		var c_desi_dmg = "Damage: " + str(gunSettingConfig.get_value("Desi_Katta", "damage"))
		var c_desi_fireRate = "Firerate: " + str(gunSettingConfig.get_value("Desi_Katta", "fireRate"))
		var c_desi_reload = "Reload Time: " + str(gunSettingConfig.get_value("Desi_Katta", "reloadTime"))
		$"CanvasLayer/shopContainer/Weapons/desi_katta/current_desi_katta/level".text = c_level
		$"CanvasLayer/shopContainer/Weapons/desi_katta/current_desi_katta/dmg".text = c_desi_dmg
		$"CanvasLayer/shopContainer/Weapons/desi_katta/current_desi_katta/Firerate".text = c_desi_fireRate
		$"CanvasLayer/shopContainer/Weapons/desi_katta/current_desi_katta/reload_time".text = c_desi_reload
		
		#n_desi_katta_label
		var c_desi_price = "💎" + str(gunSettingConfig.get_value("Desi_Katta", "desi_price"))
		$"CanvasLayer/shopContainer/Weapons/desi_katta/next_desi_katta/dmg".text = c_desi_dmg + " + [color=green]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/desi_katta/next_desi_katta/Firerate".text = c_desi_fireRate + " - [color=red]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/desi_katta/next_desi_katta/Reload Time".text = c_desi_reload + " - [color=red]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/desi_katta/next_desi_katta/desi_katta_upgrade".text = c_desi_price
		
		#current_m4_label
		var c_m4_level = "Level " + str(gunSettingConfig.get_value("m469", "level"))
		var c_m4_dmg = "Damage: " + str(gunSettingConfig.get_value("m469", "damage"))
		var c_m4_fr = "Firerate: " + str(gunSettingConfig.get_value("m469", "fireRate"))
		var c_m4_reload = "Reload Time: " + str(gunSettingConfig.get_value("m469", "reloadTime"))
		$"CanvasLayer/shopContainer/Weapons/m469/current_m469/level".text = c_m4_level
		$"CanvasLayer/shopContainer/Weapons/m469/current_m469/dmg".text = c_m4_dmg
		$"CanvasLayer/shopContainer/Weapons/m469/current_m469/Firerate".text = c_m4_fr
		$"CanvasLayer/shopContainer/Weapons/m469/current_m469/reload_time".text = c_m4_reload
		#next_m4_label
		var c_m4_price = "💎" + str(gunSettingConfig.get_value("m469", "m469_price"))
		$"CanvasLayer/shopContainer/Weapons/m469/next_m469/dmg".text = c_m4_dmg + " + [color=green]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/m469/next_m469/Firerate".text = c_m4_fr +  " - [color=red]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/m469/next_m469/Reload Time".text = c_m4_reload + " - [color=red]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/m469/next_m469/m469_upgrade".text = c_m4_price
		
		#current_shotgun_label
		var c_shotgun_level = "Level " + str(gunSettingConfig.get_value("shotgun", "level"))
		var c_shotgun_dmg = "Damage: " + str(gunSettingConfig.get_value("shotgun", "damage"))
		var c_shotgun_fr = "Firerate: " + str(gunSettingConfig.get_value("shotgun", "fireRate"))
		var c_shotgun_reload = "Reload Time: " + str(gunSettingConfig.get_value("shotgun", "reloadTime"))
		$"CanvasLayer/shopContainer/Weapons/shotgun/current_shotgun/level".text = c_shotgun_level
		$"CanvasLayer/shopContainer/Weapons/shotgun/current_shotgun/dmg".text = c_shotgun_dmg
		$"CanvasLayer/shopContainer/Weapons/shotgun/current_shotgun/Firerate".text = c_shotgun_fr
		$"CanvasLayer/shopContainer/Weapons/shotgun/current_shotgun/reload_time".text = c_shotgun_reload
		#next_shotgun_label
		var c_shotgun_price = "💎" + str(gunSettingConfig.get_value("shotgun", "shotgun_price"))
		$"CanvasLayer/shopContainer/Weapons/shotgun/next_shotgun/dmg".text = c_shotgun_dmg +  " + [color=green]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/shotgun/next_shotgun/Firerate".text =c_shotgun_fr +  " - [color=red]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/shotgun/next_shotgun/Reload Time".text =c_shotgun_reload +  " - [color=red]0.01[/color]"
		$"CanvasLayer/shopContainer/Weapons/shotgun/next_shotgun/shotgun_upgrade".text = c_shotgun_price
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


func _on_desi_katta_upgrade_pressed():
	$"click_sound".play()
	#current diamonds
	var current_dm = ConfigFile.new()
	current_dm.load("user://GameData.cfg")
	var total_gems = current_dm.get_value("GameData", "gems")
	
	var config = ConfigFile.new()
	config.load("user://gunSetting.cfg")
	var price = config.get_value("Desi_Katta", "desi_price")
	
	if total_gems >= price:
		var cal_gem = current_dm.get_value("GameData", "gems") - price
		var cal_level = config.get_value("Desi_Katta", "level") + 1
		var cal_dmg = config.get_value("Desi_Katta", "damage") + 0.01
		var cal_fire_rate = config.get_value("Desi_Katta", "fireRate") - 0.01
		var cal_reload_time = config.get_value("Desi_Katta", "reloadTime") - 0.01
		var next_price = config.get_value("Desi_Katta", "desi_price") * 2
		config.set_value("Desi_Katta", "level", cal_level)
		config.set_value("Desi_Katta", "damage", cal_dmg)
		config.set_value("Desi_Katta", "fireRate", cal_fire_rate)
		config.set_value("Desi_Katta", "reloadTime", cal_reload_time)
		current_dm.set_value("GameData", "gems", cal_gem)
		config.set_value("Desi_Katta", "desi_price",next_price)
		current_dm.save("user://GameData.cfg")
		config.save("user://gunSetting.cfg")
		print(cal_dmg)


func _on_m_469_upgrade_pressed():
	$"click_sound".play()
	#current diamonds
	var current_dm = ConfigFile.new()
	current_dm.load("user://GameData.cfg")
	var total_gems = current_dm.get_value("GameData", "gems")
	
	var config = ConfigFile.new()
	config.load("user://gunSetting.cfg")
	var price = config.get_value("m469", "m469_price")
	
	if total_gems >= price:
		var cal_gem = current_dm.get_value("GameData", "gems") - price
		var cal_level = config.get_value("m469", "level") + 1
		var cal_dmg = config.get_value("m469", "damage") + 0.01
		var cal_fire_rate = config.get_value("m469", "fireRate") - 0.01
		var cal_reload_time = config.get_value("m469", "reloadTime") - 0.01
		var next_price = config.get_value("m469", "m469_price") * 2
		config.set_value("m469", "level", cal_level)
		config.set_value("m469", "damage", cal_dmg)
		config.set_value("m469", "fireRate", cal_fire_rate)
		config.set_value("m469", "reloadTime", cal_reload_time)
		current_dm.set_value("GameData", "gems", cal_gem)
		config.set_value("m469", "m469_price",next_price)
		current_dm.save("user://GameData.cfg")
		config.save("user://gunSetting.cfg")
		print(cal_dmg)


func _on_shotgun_upgrade_pressed():
	$"click_sound".play()
	#current diamonds
	var current_dm = ConfigFile.new()
	current_dm.load("user://GameData.cfg")
	var total_gems = current_dm.get_value("GameData", "gems")
	
	var config = ConfigFile.new()
	config.load("user://gunSetting.cfg")
	var price = config.get_value("shotgun", "shotgun_price")
	
	if total_gems >= price:
		var cal_gem = current_dm.get_value("GameData", "gems") - price
		var cal_level = config.get_value("shotgun", "level") + 1
		var cal_dmg = config.get_value("shotgun", "damage") + 0.01
		var cal_fire_rate = config.get_value("shotgun", "fireRate") - 0.01
		var cal_reload_time = config.get_value("shotgun", "reloadTime") - 0.01
		var next_price = config.get_value("shotgun", "shotgun_price") * 2
		config.set_value("shotgun", "level", cal_level)
		config.set_value("shotgun", "damage", cal_dmg)
		config.set_value("shotgun", "fireRate", cal_fire_rate)
		config.set_value("shotgun", "reloadTime", cal_reload_time)
		current_dm.set_value("GameData", "gems", cal_gem)
		config.set_value("shotgun", "shotgun_price",next_price)
		current_dm.save("user://GameData.cfg")
		config.save("user://gunSetting.cfg")
		print(cal_dmg)
