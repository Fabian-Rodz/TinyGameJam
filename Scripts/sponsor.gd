# Sponsor script
extends Node2D
var is_p1
var color = "green"

@onready var sprite: AnimatedSprite2D

@onready var p1_red_animated_sprite_2d: AnimatedSprite2D = $P1RedAnimatedSprite2D
@onready var p1_yellow_animated_sprite_2d: AnimatedSprite2D = $P1YellowAnimatedSprite2D
@onready var p1_blue_animated_sprite_2d_3: AnimatedSprite2D = $P1BlueAnimatedSprite2D3
@onready var p1_green_animated_sprite_2d_4: AnimatedSprite2D = $P1GreenAnimatedSprite2D4

@onready var p2_red_animated_sprite_2d: AnimatedSprite2D = $P2RedAnimatedSprite2D
@onready var p2_yellow_animated_sprite_2d: AnimatedSprite2D = $P2YellowAnimatedSprite2D
@onready var p2_blue_animated_sprite_2d: AnimatedSprite2D = $P2BlueAnimatedSprite2D
@onready var p2_green_animated_sprite_2d: AnimatedSprite2D = $P2GreenAnimatedSprite2D

var colors: Array[AnimatedSprite2D] = []


func change_sprite(state: String):
	sprite.play(state)

func change_color(newColor: String):
	color = newColor
	if is_p1:
		if color == "red":
			sprite = p1_red_animated_sprite_2d
		if color == "yellow":
			sprite = p1_yellow_animated_sprite_2d
		if color == "blue":
			sprite = p1_blue_animated_sprite_2d_3 
		if color == "green":
			sprite = p1_green_animated_sprite_2d_4
	else:
		if color == "red":
			sprite = p2_red_animated_sprite_2d
		if color == "yellow":
			sprite = p2_yellow_animated_sprite_2d
		if color == "blue":
			sprite = p2_blue_animated_sprite_2d 
		if color == "green":
			sprite = p2_green_animated_sprite_2d
	
	for list_color in colors:
		list_color.hide()
	sprite.show()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colors.append(p1_red_animated_sprite_2d)
	colors.append(p1_yellow_animated_sprite_2d)
	colors.append(p1_blue_animated_sprite_2d_3)
	colors.append(p1_green_animated_sprite_2d_4)
	colors.append(p2_red_animated_sprite_2d)
	colors.append(p2_yellow_animated_sprite_2d) 
	colors.append(p2_blue_animated_sprite_2d)
	colors.append(p2_green_animated_sprite_2d) 
	change_color(color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
