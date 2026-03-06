extends Area2D
class_name Bullet

@export var speed: float = 600.0

func _process(delta: float) -> void:
	position.y -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		if area.has_method("die"):
			area.die()
		queue_free()
