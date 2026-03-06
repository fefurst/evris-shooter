extends Area2D
class_name EnemyBullet

@export var speed: float = 400.0

func _process(delta: float) -> void:
	position.y += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		if area.has_method("take_damage"):
			area.take_damage()
		queue_free()
