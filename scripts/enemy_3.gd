extends CharacterBody2D


var player_position := Vector2.ZERO

func _physics_process(delta):
	velocity = position.direction_to(player_position) * 150
	
	if position.distance_to(player_position) > 10:
		move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("desi_katta_bullet"):
		if $"healthbar".value != 0:
			$"healthbar".value -= 1
		if $"healthbar".value == 0:
			queue_free()
	
	if area.is_in_group("m469_bullet"):
		if $"healthbar".value != 0:
			$"healthbar".value -= 1
		if $"healthbar".value == 0:
			queue_free()
	
	if area.is_in_group("shotgun_bullet"):
		if $"healthbar".value != 0:
			$"healthbar".value -= 5
		if $"healthbar".value == 0:
			queue_free()
