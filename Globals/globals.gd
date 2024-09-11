extends Node

signal score_change
signal lives_change

var SCORE: int = 0:
	set(value):
		SCORE = value;
		emit_signal("score_change");
	get:
		return SCORE;

var LIVES: int = 5:
	set(value):
		LIVES = value;
		emit_signal("lives_change");
	get:
		return LIVES;
