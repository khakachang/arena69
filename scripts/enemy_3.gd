extends CharacterBody2D

@export var desi_katta_dmg := 1.0
@export var m469_dmg := 1.0
@export var shotgun_dmg := 3.0
@export var dmg_to_player := 10.0
var player_position := Vector2.ZERO
var gem_scene = load("res://scenes/gem.tscn")
var speed = 50
func _ready():
	$"AnimatedSprite2D".play("walk")
func _physics_process(delta):
	velocity = position.direction_to(player_position) * speed
	
	if position.distance_to(player_position) > 10:
		move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("desi_katta_bullet"):
		if $"healthbar".value != 0:
			$"healthbar".value -= desi_katta_dmg
		if $"healthbar".value == 0:
			call_deferred("drop_item")
	
	if area.is_in_group("m469_bullet"):
		if $"healthbar".value != 0:
			$"healthbar".value -= m469_dmg
		if $"healthbar".value == 0:
			call_deferred("drop_item")
	
	if area.is_in_group("shotgun_bullet"):
		if $"healthbar".value != 0:
			$"healthbar".value -= shotgun_dmg
		if $"healthbar".value == 0:
			call_deferred("drop_item")

func drop_item():
	var gem = gem_scene.instantiate()
	gem.position = position
	get_parent().add_child(gem)
	queue_free()
