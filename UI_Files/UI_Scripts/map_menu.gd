extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var config = ConfigFile.new()
	var err = config.load("user://GameData.cfg")
	
	if err != OK:
		config.set_value("GameData", "gems", 0)
		config.save("user://GameData.cfg")
	if err == OK:
		$"gem_indicator".text = str(config.get_value("GameData","gems"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Gems updating
	var gemConfig = ConfigFile.new()
	var gem_config_exist = gemConfig.load("user://GameData.cfg")
	if gem_config_exist == OK:
		$"gem_indicator".text = str(gemConfig.get_value("GameData","gems"))


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/home.tscn")


func _on_map_1_pressed():
	get_tree().change_scene_to_file("res://scenes/game_load_screen.tscn")
