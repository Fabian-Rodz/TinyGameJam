extends Node

var is_paused = false
@onready var pause_background: TextureRect = $PauseBackground
@onready var pause_label: Label = $PauseLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_background.hide()
	pause_label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause-return"):
		if is_paused:
			is_paused = false
			pause_background.hide()
			pause_label.hide()
		else:
			is_paused = true
			pause_background.show()
			pause_label.show()



func _on_back_to_start_pressed() -> void:
	if not is_paused:
		get_tree().change_scene_to_file("res://Scenes/End_screen.tscn")
