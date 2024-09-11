extends Node2D

var laser_scene = preload("res://Scenes/laser.tscn")
var med_ast_scene = preload("res://Scenes/med_asteroid.tscn")
var small_ast_scene = preload("res://Scenes/small_asteroid.tscn")

var player_scene = preload("res://Scenes/ship.tscn")

@onready var player_ship = $Ship;


func _ready():
	$MedAsteroid.connect("kill_player", _on_asteroid_kill_player);

func _process(_delta):
	pass

func _on_ship_blast(pos):
	var laser = laser_scene.instantiate()
	
	laser.rotation = player_ship.rotation
	laser.position = pos;
	$Projectiles.add_child(laser);


func _on_asteroid_spawn_med_ast(pos):
	var ast1 = med_ast_scene.instantiate()
	var ast2 = med_ast_scene.instantiate()
	
	ast1.position = pos;
	ast2.position = pos;
	
	call_deferred("add_child", ast1)
	call_deferred("add_child", ast2)
	
	ast1.connect("spawn_small_ast", _on_med_asteroid_spawn_small_ast);
	ast2.connect("spawn_small_ast", _on_med_asteroid_spawn_small_ast);
	
	ast1.connect("kill_player", _on_asteroid_kill_player);
	ast2.connect("kill_player", _on_asteroid_kill_player);


func _on_med_asteroid_spawn_small_ast(pos):
	var ast1 = small_ast_scene.instantiate()
	var ast2 = small_ast_scene.instantiate()
	var ast3 = small_ast_scene.instantiate()
	
	ast1.position = pos;
	ast2.position = pos;
	ast3.position = pos;
	
	call_deferred("add_child", ast1)
	call_deferred("add_child", ast2)
	call_deferred("add_child", ast3)
	
	ast1.connect("kill_player", _on_asteroid_kill_player);
	ast2.connect("kill_player", _on_asteroid_kill_player);
	ast3.connect("kill_player", _on_asteroid_kill_player);


func _on_asteroid_kill_player(body):
	body.damage()
	
	if Globals.LIVES > 0:
		player_ship = player_scene.instantiate()
		
		player_ship.position = Vector2(546, 345);
		player_ship.connect("blast", _on_ship_blast);
		
		call_deferred("add_child", player_ship)
