extends Node2D

@export var enemy_scene: PackedScene
var screen_size: Vector2
var enemies_remaining: int = 0

@onready var score_label: Label = $HUD/MarginContainer/HBoxContainer/ScoreLabel
@onready var lives_label: Label = $HUD/MarginContainer/HBoxContainer/LivesLabel
@onready var level_label: Label = $HUD/MarginContainer/HBoxContainer/LevelLabel

func _ready() -> void:
	screen_size = get_viewport_rect().size
	GameManager.score_changed.connect(_on_score_changed)
	GameManager.lives_changed.connect(_on_lives_changed)
	GameManager.level_changed.connect(_on_level_changed)
	_on_score_changed(GameManager.score)
	_on_lives_changed(GameManager.lives)
	_on_level_changed(GameManager.level)
	
	# Stop the timer as we will control waves manually
	$Timer.stop()
	start_level_wave()

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)

func _on_lives_changed(new_lives: int) -> void:
	lives_label.text = "Lives: " + str(new_lives)

func _on_level_changed(new_level: int) -> void:
	if level_label:
		level_label.text = "Level: " + str(new_level)

func start_level_wave() -> void:
	# Keep basic wave limits
	var cols = min(5 + (GameManager.level / 2), 8)
	var padding = 55
	var offset = (screen_size.x - (cols * padding)) / 2 + (padding / 2)
	
	enemies_remaining = cols
	
	for i in range(cols):
		var enemy = enemy_scene.instantiate()
		
		# Assign behavior based on level progression
		# Level 1: All Ping Pong
		# Level 2+: Introduce Sine Wave
		# Level 3+: Introduce Chasers
		# Level 4+: Introduce Kamikaze
		var behavior = 0 # PING_PONG defaults
		if GameManager.level >= 2 and randf() > 0.6:
			behavior = 1 # SINE_WAVE
		if GameManager.level >= 3 and randf() > 0.7:
			behavior = 2 # CHASER
		if GameManager.level >= 4 and randf() > 0.8:
			behavior = 3 # KAMIKAZE
			
		enemy.behavior = behavior
		
		get_tree().root.add_child(enemy)
		
		var final_pos = Vector2(offset + (i * padding), 50)
		final_pos.x += (i % 2) * 20
		enemy.setup(final_pos)
		
		enemy.tree_exited.connect(_on_enemy_destroyed)

func _on_enemy_destroyed() -> void:
	enemies_remaining -= 1
	if enemies_remaining <= 0:
		# Next Level
		GameManager.level += 1
		$Timer.start() # Reuse timer for a brief pause before next wave

func _on_timer_timeout() -> void:
	$Timer.stop()
	if enemy_scene:
		start_level_wave()
