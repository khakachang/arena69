extends CharacterBody2D


var player_position := Vector2.ZERO

var is_playing_hit = false
var can_attack = false
func _physics_process(delta):
	velocity = position.direction_to(player_position) * 50
	
	if position.distance_to(player_position) > 15:
		move_and_slide()


	if can_attack != true:
		if is_playing_hit != true:
			$"AnimatedSprite2D".play("walk")
	else:
		$"AnimatedSprite2D".play("attack")
		get_parent().get_node("player").get_node("healthbar").value -= 1 * delta
		
func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		can_attack = true
	if area.is_in_group("desi_katta_bullet"):
		if $"healthbar".value != 0:
			is_playing_hit = true
			$"AnimatedSprite2D".play("hit")
			$"hit_animation".start()
			$"healthbar".value -= 1
		if $"healthbar".value == 0:
			queue_free()
	
	if area.is_in_group("m469_bullet"):
		if $"healthbar".value != 0:
			is_playing_hit = true
			$"AnimatedSprite2D".play("hit")
			$"hit_animation".start()
			$"healthbar".value -= 1
		if $"healthbar".value == 0:
			queue_free()
	
	if area.is_in_group("shotgun_bullet"):
		if $"healthbar".value != 0:
			is_playing_hit = true
			$"AnimatedSprite2D".play("hit")
			$"hit_animation".start()
			$"healthbar".value -= 5
		if $"healthbar".value == 0:
			queue_free()

func _on_area_2d_area_exited(area):
	if area.is_in_group("player"):
		can_attack = false
func _on_hit_animation_timeout():
	is_playing_hit = false


