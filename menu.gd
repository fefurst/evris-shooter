extends Control

@onready var highscore_label: Label = $VBoxContainer/HighscoreLabel

func _ready() -> void:
	highscore_label.text = "Highscore: " + str(GameManager.highscore)

func _on_start_button_pressed() -> void:
	GameManager.start_game()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
