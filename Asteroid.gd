extends RigidBody2D

@export var size_multiplyer = 5
@export var num_of_sides = 6
@export var size = 1
var bounds = PackedVector2Array()

func generate_bounds():
	for i in range(num_of_sides):
		var max_radius = (size * size_multiplyer) + (size_multiplyer / 2.0)
		var min_radius = (size * size_multiplyer) - (size_multiplyer / 2.0)
		var radius = randf_range(min_radius,max_radius)
		var vector = Vector2.UP.rotated(TAU / num_of_sides * i) * radius
		bounds.push_back(vector)

func _ready():
	generate_bounds()
	$CollisionPolygon2D.polygon = bounds
	
func _draw():
	var colors = PackedColorArray([Color.WHITE])
	
	draw_polygon(bounds, colors)
	
func _process(delta : float):
	position.x = wrapf(position.x, 0.0, DisplayServer.window_get_size(0).x)
	position.y = wrapf(position.y, 0.0, DisplayServer.window_get_size(0).y)
