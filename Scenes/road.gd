extends Node2D

@export var scroll_speed: float = 250.0

@onready var road_1: Sprite2D = $Road1
@onready var road_2: Sprite2D = $Road2

func _ready() -> void:
	if road_1.texture == null or road_2.texture == null:
		print("Road1 or Road2 has no texture assigned!")
		return

	var road_width = road_1.texture.get_width() * road_1.scale.x

	road_1.position.x = 0
	road_2.position.x = road_width

func _process(delta: float) -> void:
	if road_1.texture == null or road_2.texture == null:
		return

	var road_width = road_1.texture.get_width() * road_1.scale.x

	road_1.position.x -= scroll_speed * delta
	road_2.position.x -= scroll_speed * delta

	if road_1.position.x <= -road_width:
		road_1.position.x = road_2.position.x + road_width

	if road_2.position.x <= -road_width:
		road_2.position.x = road_1.position.x + road_width
