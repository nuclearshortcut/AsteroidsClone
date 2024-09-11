extends CharacterBody2D

var rotation_direction = 0;
var rotation_speed = 2.5 # speed of rotation
var thrust_speed = 0;
var can_shoot: bool = true;
var direction = Vector2(0, 0)

var accel = 1;
var decel = 1;

signal blast(pos)

func get_input(delta):
	# Gets rotation direction
	# Get axis returns -1 for RotateLeft, and 1 for RotateRight
	rotation_direction = Input.get_axis("RotateLeft", "RotateRight")
	
	if Input.is_action_pressed("Thrust"):
		# ship accels to a thrust_speed max of 10
		thrust_speed += accel
		if thrust_speed > 1000:
			thrust_speed = 1000
		$AnimationPlayer.play("Fly")
	else:
		# ship decels to a thrus_speed min of 0
		thrust_speed -= decel
		if thrust_speed < 0:
			thrust_speed = 0
	
	velocity = transform.x * thrust_speed
	
	if Input.is_action_just_released("Thrust"):
		$AnimationPlayer.stop()
	
	if Input.is_action_pressed("Shoot") and can_shoot:
		shoot()
		can_shoot = false
		$ShootTimer.start()

func shoot():
	blast.emit($Marker2D.global_position)
	print("shoot")

func _physics_process(delta):
	get_input(delta)
	
	# Sets rotation. If positive, right. If negative, left
	rotation += rotation_direction * rotation_speed * delta
	
	move_and_slide()
	#print(velocity)
	
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


func _on_shoot_timer_timeout():
	can_shoot = true;

func damage():
	Globals.LIVES -= 1;
	queue_free()
