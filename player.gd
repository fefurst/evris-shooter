extends Area2D
class_name Player

@export var speed: float = 300.0
@export var bullet_scene: PackedScene

var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = $Marker2D.global_position

func take_damage() -> void:
	GameManager.lives -= 1
	if GameManager.lives <= 0:
		GameManager.save_highscore()
		get_tree().change_scene_to_file("res://menu.tscn")
	else:
		# Respawn or blink effect could go here
		position = Vector2(screen_size.x / 2, screen_size.y - 70)
