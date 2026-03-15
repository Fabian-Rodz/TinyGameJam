extends Node
@onready var player_1: CharacterBody2D = $player1
@onready var player_2: CharacterBody2D = $player2
@onready var sponsor_1: AnimatedSprite2D = $Sponsor1
@onready var sponsor_2: AnimatedSprite2D = $Sponsor2
@onready var p1_back: TextureButton = $Control/p1_back
@onready var p1_forward: TextureButton = $Control/p1_forward
@onready var p2_back: TextureButton = $Control/p2_back
@onready var p2_forward: TextureButton = $Control/p2_forward

var colors_1 = ["red","yellow","blue","green"]
var index_1 = 0
var colors_2 = ["red","yellow","blue","green"]
var index_2 = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.p1_color = "red"
	Global.p2_color = "blue"
	player_1.change_color(Global.p1_color)
	player_2.change_color(Global.p2_color)
	sponsor_1.play(Global.p1_color)
	sponsor_2.play(Global.p2_color)
	Global.play_shared_music(Global.MENU_MUSIC)

	Global.p1_color = "red"
	Global.p2_color = "blue"

	player_1.change_color(Global.p1_color)
	player_2.change_color(Global.p2_color)

	sponsor_1.play(Global.p1_color)
	sponsor_2.play(Global.p2_color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_p_1_forward_pressed() -> void:
	index_1 += 1
	if index_1 > 3:
		index_1 = 0
		
	Global.p1_color = colors_1[index_1]
	player_1.change_color(Global.p1_color)
	sponsor_1.play(Global.p1_color)



func _on_p_1_back_pressed() -> void:
	index_1 -= 1
	if index_1 < 0:
		index_1 = 3
		
	Global.p1_color = colors_1[index_1]
	player_1.change_color(Global.p1_color)
	sponsor_1.play(Global.p1_color)


func _on_p_2_forward_pressed() -> void:
	index_2 += 1
	if index_2 > 3:
		index_2 = 0
		
	Global.p2_color = colors_2[index_2]
	player_2.change_color(Global.p2_color)
	sponsor_2.play(Global.p2_color)



func _on_p_2_back_pressed() -> void:
	index_2 -= 1
	if index_2 < 0:
		index_2 = 3
		
	Global.p2_color = colors_2[index_2]
	player_2.change_color(Global.p2_color)
	sponsor_2.play(Global.p2_color)


func _on_start_game_pressed() -> void:
	Global.p1_color = colors_1[index_1]
	Global.p2_color = colors_2[index_2]
	get_tree().change_scene_to_file("res://Scenes/road.tscn")



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
