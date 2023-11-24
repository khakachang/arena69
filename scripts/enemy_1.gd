extends CharacterBody2D


var player_position

func _physics_process(delta):
	velocity = position.direction_to(player_position)
	move_and_slide()
