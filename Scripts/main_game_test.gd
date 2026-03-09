# Main game test script
extends Node2D
@onready var player_1: CharacterBody2D = $player1
@onready var player_2: CharacterBody2D = $player2
@onready var sponsor_1: Node2D = $sponsor1
@onready var sponsor_2: Node2D = $sponsor2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1.is_p1 = true
	player_2.is_p1 = false
	sponsor_1.is_p1 = true
	sponsor_1.change_color("green")
	sponsor_2.is_p1 = false
	sponsor_2.change_color("yellow")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sponsor_1.is_p1 = true
	sponsor_2.is_p1 = false
	if not player_1.is_hit:
		sponsor_1.change_sprite("1st")
	if not player_2.is_hit:
		sponsor_2.change_sprite("1st")
	
	if player_1.points > player_2.points:
		sponsor_1.change_sprite("1st")
		sponsor_2.change_sprite("2nd")
	if player_1.points < player_2.points:
		sponsor_1.change_sprite("2nd")
		sponsor_2.change_sprite("1st")
	if player_1.is_hit:
		sponsor_1.change_sprite("hit")
	if player_2.is_hit:
		sponsor_2.change_sprite("hit")
