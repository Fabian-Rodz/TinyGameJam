extends Node
@onready var player2Score: Label = $"sponsor2/Label"
@onready var player1Score: Label = $"sponsor1/Label"
@onready var winner: Label = $"Label2"
@onready var sponsor1: Node2D = $sponsor1
@onready var sponsor2: Node2D = $sponsor2

@onready var player_1: CharacterBody2D = $VBoxContainer/HBoxContainer/player1
@onready var player_2: CharacterBody2D = $VBoxContainer/HBoxContainer/player2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1.change_color(Global.p1_color)
	player_1.change_state(player_1.Car_State.End_Screen)
	sponsor1.is_p1 = true
	sponsor1.change_color(Global.p1_color)
	
	player_2.change_color(Global.p2_color)
	player_2.change_state(player_2.Car_State.End_Screen)
	sponsor2.is_p1 = false
	sponsor2.change_color(Global.p2_color)
	
	if player1Score:
		player1Score.text = "Score: " + str(Global.score_player1)
	if player2Score:
		player2Score.text = "Score: " + str(Global.score_player2)
	if Global.score_player1>Global.score_player2:
		winner.text="Player 1 Wins"
		player_1.sprite.play("winner")
		sponsor1.change_sprite("winner")
		
		player_2.sprite.play("loser")
		sponsor2.change_sprite("loser")
	elif Global.score_player1<Global.score_player2:
		winner.text="Player 2 Wins"
		player_1.sprite.play("loser")
		sponsor1.change_sprite("loser")
		
		player_2.sprite.play("winner")
		sponsor2.change_sprite("winner")
	else:
		winner.text="it's a tie"
		player_1.sprite.play("loser")
		sponsor1.change_sprite("loser")
		
		player_2.sprite.play("loser")
		sponsor2.change_sprite("loser")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_replay_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/road.tscn")


func _on_start_screen_pressed() -> void:
	Global.score_player1=0
	Global.score_player2=0
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
	

func _on_exit_pressed() -> void:
	get_tree().quit()
