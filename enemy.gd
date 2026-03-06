extends Area2D
class_name Enemy

@export var speed: float = 100.0
enum Behavior { PING_PONG, SINE_WAVE, CHASER, KAMIKAZE }
@export var behavior: Behavior = Behavior.PING_PONG
@export var bullet_scene: PackedScene = preload("res://enemy_bullet.tscn")

var direction: int = 1
var screen_size: Vector2
var start_pos: Vector2
var current_base_y: float
var kamikaze_timer: float = 0.0
var dive: bool = false
var shoot_timer: float = 0.0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	connect("area_entered", _on_area_entered)
	_reset_shoot_timer()
	
	if behavior == Behavior.KAMIKAZE:
		kamikaze_timer = randf_range(1.0, 4.0)
		# Update color visual indication
		modulate = Color(1, 0, 1) # Purple
	elif behavior == Behavior.CHASER:
		modulate = Color(0, 1, 1) # Cyan
	elif behavior == Behavior.SINE_WAVE:
		modulate = Color(0, 1, 0) # Green
	else:
		# PING_PONG or default
		modulate = Color(1, 0.2, 0.2) # Vibrant Bright Red

func setup(pos: Vector2) -> void:
	global_position = pos
	start_pos = position
	current_base_y = position.y

func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		if area.has_method("take_damage"):
			area.take_damage()
		queue_free()

func _process(delta: float) -> void:
	# Handling Shooting
	shoot_timer -= delta
	if shoot_timer <= 0:
		shoot()
		_reset_shoot_timer()

	match behavior:
		Behavior.PING_PONG:
			_process_ping_pong(delta)
		Behavior.SINE_WAVE:
			_process_sine_wave(delta)
		Behavior.CHASER:
			_process_chaser(delta)
		Behavior.KAMIKAZE:
			_process_kamikaze(delta)
			
	# General Out of Bounds Respawn (Left, Right, Bottom)
	if position.y > screen_size.y + 50 or position.x < -50 or position.x > screen_size.x + 50:
		_respawn_at_top()

func _reset_shoot_timer() -> void:
	# Random shoot delay between 2 to 6 seconds depending on luck
	shoot_timer = randf_range(2.0, 6.0)

func shoot() -> void:
	if bullet_scene and global_position.y > 0 and global_position.y < screen_size.y:
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = global_position
		# Slight offset to not spawn exactly inside the enemy visually
		bullet.position.y += 20

func _respawn_at_top() -> void:
	position = start_pos
	current_base_y = start_pos.y
	direction = 1
	_reset_shoot_timer()
	# Reset Kamikaze state
	if behavior == Behavior.KAMIKAZE:
		kamikaze_timer = randf_range(1.0, 4.0)
		dive = false

func _process_ping_pong(delta: float) -> void:
	position.x += speed * direction * delta
	if position.x > screen_size.x - 32 and direction == 1:
		direction = -1
		position.y += 32
	elif position.x < 32 and direction == -1:
		direction = 1
		position.y += 32

func _process_sine_wave(delta: float) -> void:
	# Keep ping-pong X movement
	position.x += speed * direction * delta
	if position.x > screen_size.x - 32 and direction == 1:
		direction = -1
		current_base_y += 32
	elif position.x < 32 and direction == -1:
		direction = 1
		current_base_y += 32
	
	# Add vertical sine oscillation
	var time = Time.get_ticks_msec() / 1000.0
	position.y = current_base_y + sin(time * 5.0) * 40.0

func _process_chaser(delta: float) -> void:
	# Slowly drift down
	position.y += (speed * 0.2) * delta
	
	# Find player to chase
	var players = get_tree().get_nodes_in_group("player_group")
	if players.size() > 0:
		var target_x = players[0].global_position.x
		var diff = target_x - position.x
		if abs(diff) > 5:
			position.x += sign(diff) * (speed * 0.8) * delta

func _process_kamikaze(delta: float) -> void:
	if dive:
		position.y += (speed * 3.0) * delta
	else:
		# Hover ping pong
		position.x += (speed * 0.5) * direction * delta
		if position.x > screen_size.x - 32 and direction == 1:
			direction = -1
		elif position.x < 32 and direction == -1:
			direction = 1
			
		kamikaze_timer -= delta
		if kamikaze_timer <= 0:
			dive = true

func die() -> void:
	GameManager.score += 10
	queue_free()
