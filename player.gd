extends Area2D

signal hit

@export var jerk = 0.1
@export var max_speed = 0.01
@export var angular_speed = 3

var speed = Vector2.ZERO

var bounds = PackedVector2Array([
		Vector2(0.0, -9.0), 
		Vector2(5.0, 9.0), 
		Vector2(-5.0, 9.0)
	])
	
func _ready():
	pass
	
func start(pos : Vector2):
	position = pos
	show()
	$CollisionPolygon2D.polygon = bounds
	$CollisionPolygon2D.disabled = false

func _draw():
	var colors = PackedColorArray([Color.WHITE])
	
	draw_polygon(bounds, colors)

func _process(delta : float):
	var direction = 0
	if Input.is_action_pressed("rotate_clockwise"):
		direction = 1
	if Input.is_action_pressed("rotate_counterclockwise"):
		direction = -1
	if Input.is_action_pressed("rotate_clockwise") && Input.is_action_pressed("rotate_counterclockwise"):
		direction = 0
		
	rotation += angular_speed * PI * direction * delta
	
	var acceleration = Vector2.UP.rotated(rotation) * jerk
	var max_check = Vector2.UP.rotated(rotation) * max_speed
	
	if Input.is_action_pressed("accelerate_forward"):
		speed += acceleration
		speed.clamp(speed,max_check)
	elif Input.is_action_pressed("accelerate_backwards"):
		speed -= acceleration
		speed.clamp(-max_check,speed)
	
	position += speed * delta


func _on_body_entered(body : RigidBody2D):
	hide()
	hit.emit()
	$CollisionPolygon2D.set_deferred("disabled", true)
