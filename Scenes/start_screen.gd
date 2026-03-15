extends Node

func _ready() -> void:
	Global.play_shared_music(Global.MENU_MUSIC)

func _process(_delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ColorSelect.tscn")

func _on_how_to_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/How_to_play_screen.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
