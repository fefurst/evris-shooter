extends Node2D

@export var star_count: int = 40
@export var min_size: float = 1.0
@export var max_size: float = 2.0
@export var color_tint: Color = Color(1.0, 1.0, 1.0, 1.0)

var stars: Array = []

func _ready() -> void:
	for i in range(star_count):
		stars.append({
			"pos": Vector2(randf() * 480.0, randf() * 720.0),
			"size": randf_range(min_size, max_size),
			"alpha": randf_range(0.3, 1.0)
		})
	queue_redraw()

func _draw() -> void:
	for star in stars:
		var c = color_tint
		c.a = star["alpha"]
		draw_circle(star["pos"], star["size"], c)
