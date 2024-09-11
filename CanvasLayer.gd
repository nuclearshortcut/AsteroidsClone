extends CanvasLayer

func _ready():
	Globals.connect("lives_change", _update_lives_text);
	Globals.connect("score_change", _update_score_text);

func _process(delta):
	_update_score_text()
	_update_lives_text()

func _update_score_text():
	$Score.text = "SCORE: " + str(Globals.SCORE);

func _update_lives_text():
	$Lives.text = "LIVES: " + str(Globals.LIVES);
