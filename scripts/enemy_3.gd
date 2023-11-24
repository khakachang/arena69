extends CharacterBody2D


var player_position := Vector2.ZERO

func _physics_process(delta):
	velocity = position.direction_to(player_position) * 50
	
	if position.distance_to(player_position) > 10:
		move_and_slide()
