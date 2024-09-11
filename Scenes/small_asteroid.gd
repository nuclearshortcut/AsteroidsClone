extends Area2D

var SPEED = 250;

var ranx;
var rany;
var random_direction: Vector2

signal kill_player(body)

func _ready():
	randomize()
	rotation_degrees = randi_range(0, 360)
	ranx = randf_range(-1, 1)
	rany = randf_range(-1, 1)
	random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
func _physics_process(delta):
	# Move asteroid in random direction
	position += random_direction * SPEED * delta;
	
	# Loop back from end of screen
	var screen_size = get_viewport_rect().size
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0;
	if global_position.x < 0:
		global_position.x = screen_size.x;
	elif global_position.x > screen_size.x:
		global_position.x = 0;

func damage():
	print("hit")
	# gives 100 points
	Globals.SCORE += 100;
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		# destroy player
		kill_player.emit(body)
