extends Area2D


func _ready():
	$"AnimationPlayer".play("hovering")


func _on_dismiss_timeout():
	queue_free()
