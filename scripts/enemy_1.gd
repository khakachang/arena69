extends CharacterBody2D
@export var desi_katta_dmg := 1.0
@export var m469_dmg := 1.0
@export var shotgun_dmg := 3.0
@export var dmg_to_player := 10.0
var player_position := Vector2.ZERO

var is_playing_hit = false
var can_attack = false

var gem_scene = load("res://scenes/gem.tscn")
var desi_katta_scene = load("res://scenes/desi_katta_dropeed.tscn")
var m469_scene = load("res://scenes/m_469_dropped.tscn")
var shotgun_scene = load("res://scenes/shotgun_dropped.tscn")
var speed : float
var rg = RandomNumberGenerator.new()
var start_speed = 40
var end_speed = 60
func _ready():
	speed = rg.randf_range(start_speed, end_speed)
func _physics_process(delta):
	velocity = position.direction_to(player_position) * speed
	
	if position.distance_to(player_position) > 15:
		move_and_slide()


	if can_attack != true:
		if is_playing_hit != true:
			$"AnimatedSprite2D".play("walk")
	else:
		$"AnimatedSprite2D".play("attack")
		get_parent().get_node("player").get_node("healthbar").value -= dmg_to_player * delta
		
func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		can_attack = true
	if area.is_in_group("desi_katta_bullet"):
		if $"healthbar".value != 0:
			is_playing_hit = true
			$"AnimatedSprite2D".play("hit")
			$"hit_animation".start()
			$"healthbar".value -= desi_katta_dmg
		if $"healthbar".value == 0:
			call_deferred("drop_item")
	
	if area.is_in_group("m469_bullet"):
		if $"healthbar".value != 0:
			is_playing_hit = true
			$"AnimatedSprite2D".play("hit")
			$"hit_animation".start()
			$"healthbar".value -= m469_dmg
		if $"healthbar".value == 0:
			call_deferred("drop_item")
	
	if area.is_in_group("shotgun_bullet"):
		if $"healthbar".value != 0:
			is_playing_hit = true
			$"AnimatedSprite2D".play("hit")
			$"hit_animation".start()
			$"healthbar".value -= shotgun_dmg
		if $"healthbar".value == 0:
			call_deferred("drop_item")

func _on_area_2d_area_exited(area):
	if area.is_in_group("player"):
		can_attack = false
func _on_hit_animation_timeout():
	is_playing_hit = false

func drop_item():
	var drop_number = rg.randi_range(1,5)
	
	if drop_number == 1:
		var gem = gem_scene.instantiate()
		gem.position = position
		get_parent().add_child(gem)
	if drop_number == 2:
		var desi_katta = desi_katta_scene.instantiate()
		desi_katta.position = position
		get_parent().add_child(desi_katta)
	queue_free()
