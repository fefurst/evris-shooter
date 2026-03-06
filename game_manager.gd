extends Node

signal score_changed(new_score: int)
signal lives_changed(new_lives: int)
signal level_changed(new_level: int)

var level: int = 1:
	set(value):
		level = value
		level_changed.emit(level)

var score: int = 0:
	set(value):
		score = value
		score_changed.emit(score)

var lives: int = 3:
	set(value):
		lives = value
		lives_changed.emit(lives)

var highscore: int = 0
const SAVE_PATH = "user://highscore.save"

func _ready() -> void:
	load_highscore()

func start_game() -> void:
	score = 0
	lives = 3
	level = 1

func load_highscore() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		highscore = file.get_var()
		file.close()

func save_highscore() -> void:
	if score > highscore:
		highscore = score
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_var(highscore)
		file.close()
