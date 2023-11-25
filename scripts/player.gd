extends CharacterBody2D

@export var movementJS := VirtualJoystick

var desi_katta_scene = load("res://scenes/desi_katta.tscn")
var m469_scene = load("res://scenes/m_469.tscn")


var gun_number = 0
var current_gun = null
var move_vector := Vector2.ZERO
func _ready():
	$"AnimatedSprite2D".play("idle")
	current_gun = desi_katta_scene.instantiate()
	current_gun.position = Vector2(2,14)
	add_child(current_gun)

func _physics_process(delta):
	move_vector.x = Input.get_axis("move_left", "move_right")
	move_vector.y = Input.get_axis("move_up", "move_down")
	velocity = move_vector.normalized() * delta * 10000
	
	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("m469"):
		call_deferred("m469", area)
	
	if area.is_in_group("desi_katta"):
		call_deferred("desi_katta", area)


func m469(area):
	print("m469 picked up")
	current_gun.queue_free()
	area.queue_free()
	current_gun = m469_scene.instantiate()
	current_gun.position = Vector2(2,14)
	add_child(current_gun)

func desi_katta(area):
	print("desi_katta picked up")
	current_gun.queue_free()
	area.queue_free()
	current_gun = desi_katta_scene.instantiate()
	current_gun.position = Vector2(2,14)
	add_child(current_gun)
