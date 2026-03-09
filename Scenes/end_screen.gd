extends Node
@onready var player2Score: Label = $"Sprite2D/Label"
@onready var player1Score: Label = $"Sprite2D2/Label"
@onready var winner: Label = $"Label2"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player1Score:
		player1Score.text = "Score: " + str(Global.score_player1)
	if player2Score:
		player2Score.text = "Score: " + str(Global.score_player2)
	if Global.score_player1>Global.score_player2:
		winner.text="Player 1 Wins"
	elif Global.score_player1<Global.score_player2:
		winner.text="Player 2 Wins"
	else:
		winner.text="it's a tie"
		

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
