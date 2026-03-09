# Main game test script
extends Node2D
@onready var player_1: CharacterBody2D = $player1
@onready var player_2: CharacterBody2D = $player2
@onready var sponsor_1: Node2D = $sponsor1
@onready var sponsor_2: Node2D = $sponsor2
@onready var p1_spawn: Node2D = $P1Spawn
@onready var p2_spawn: Node2D = $P2Spawn
@onready var start_timer: Timer = $"../StartTimer"


@onready var countdown: Label = $Countdown/CountdownLabel
@onready var p1_points_label: Label = $P1Points/P1PointsLabel
@onready var p2_points_label: Label = $P2Points/P2PointsLabel


# Equal them to "red", "yellow", "blue", or "green" to change color
var p1_color
var p2_color
# 0 = startup, 1 = running, 2 = hit, 3 = jump
var p1_state = 0
var p2_state = 0
# Called when the node enters the scene tree for the first time.

func change_state_all(state:int):
	p1_state = state
	p2_state = state
	player_1.change_state(p1_state)
	player_2.change_state(p2_state)

func start_game():
	change_state_all(0)
	player_1.position = p1_spawn.position
	player_2.position = p2_spawn.position
	p1_points_label.hide()
	p2_points_label.hide()
	countdown.show()
	start_timer.start()

func _ready() -> void:
	player_1.is_p1 = true
	sponsor_1.is_p1 = true
	p1_color = "red"
	player_1.change_color(p1_color)
	sponsor_1.change_color(p1_color)
	
	player_2.is_p1 = false
	sponsor_2.is_p1 = false
	p2_color = "blue"
	player_2.change_color(p2_color)
	sponsor_2.change_color(p2_color)
	
	start_game()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	p1_points_label.text = str(player_1.points)
	p2_points_label.text = str(player_2.points)
	Global.score_player2 = player_2.points
	Global.score_player1 = player_1.points


	if start_timer.time_left >= 4:
		countdown.text = ""
	elif start_timer.time_left > 3:
		countdown.text = "3"
	elif start_timer.time_left > 2:
		countdown.text = "2"
	elif start_timer.time_left > 1:
		countdown.text = "1"
	else:
		change_state_all(1)
		p1_points_label.show()
		p2_points_label.show()
		countdown.text = "GO!"

		
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



func _on_start_timer_timeout() -> void:
	countdown.hide()
