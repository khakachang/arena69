extends CanvasLayer


func _ready():
	$"game_over_sound".play()
	var config = ConfigFile.new()
	var err = config.load("user://GameData.cfg")
	
	if err != OK:
		return
	$"enemy_killed_label".text = "💀Kill: " + str(config.get_value("GameData","kill"))
	$"gems_collected_label".text = "Gems Collected: " + str(config.get_value("GameData","gemsCollected"))


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
