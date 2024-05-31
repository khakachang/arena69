extends Area2D


func _ready():
	$"AnimationPlayer".play("idle")


func _on_timer_timeout():
	queue_free()
