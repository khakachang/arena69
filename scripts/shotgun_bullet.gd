extends Area2D

var velocity := Vector2.ZERO

func _process(delta):
	position += velocity * 1000 * delta


func _on_bullet_lifespan_timeout():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("enemy"):
		queue_free()
