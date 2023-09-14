extends Node

@export var asteroid_scene: PackedScene
@export var max_asteroids = 10
var score
var lives
var asteroid_count

func player_death():
	$ScoreTimer.stop()
	$AsteroidTimer.stop()
	
	
func new_game():
	score = 0
	asteroid_count = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$AsteroidTimer.start()
	$ScoreTimer.start()

func _on_asteroid_timer_timeout():
	if asteroid_count < max_asteroids:
		var asteroid = asteroid_scene.instantiate()
		
		var asteroid_spawn_location = get_node("AsteroidPath/AsteroidSpawnLocation")
		asteroid_spawn_location.progress_ratio = randf()
		
		var direction = asteroid_spawn_location.rotation + PI / 2
		
		asteroid.position = asteroid_spawn_location.position
		
		direction += randf_range(-PI / 4, PI / 4)
		asteroid.rotation = direction
		
		var velocity = Vector2(randf_range(25.0, 75.0), 0.0)
		asteroid.linear_velocity = velocity.rotated(direction)
		
		var size = randi_range(1, 5)
		asteroid.size = size
		
		var num_of_sides = randi_range(6, 10)
		asteroid.num_of_sides = num_of_sides
		
		add_child(asteroid)
		asteroid_count += 1
		
func _ready():
	new_game()
