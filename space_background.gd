extends ParallaxBackground

@export var scroll_speed: float = 50.0

func _process(delta: float) -> void:
	# Move the repeating textures vertically downwards
	scroll_offset.y += scroll_speed * delta
