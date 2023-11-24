extends Area2D

var velocity := Vector2.ZERO

func _process(delta):
	position += velocity * 800 * delta


func _on_bullet_lifespan_timeout():
	queue_free()
