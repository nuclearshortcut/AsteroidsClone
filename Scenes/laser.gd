extends Area2D

var SPEED = 600;

func _ready():
	pass

func _process(delta):
	position += transform.x * SPEED * delta

func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage()
		queue_free()
