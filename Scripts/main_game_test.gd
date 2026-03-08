extends Node2D
@onready var player_1: CharacterBody2D = $player1
@onready var player_2: CharacterBody2D = $player2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1.is_p1 = true
	player_2.is_p1 = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
