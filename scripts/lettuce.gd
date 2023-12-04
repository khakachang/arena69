extends Area2D


func _ready():
	$"AnimationPlayer".play("hover")


func _on_area_entered(area):
	if area.is_in_group("player"):
		queue_free()


func _on_dismiss_timeout():
	queue_free()

