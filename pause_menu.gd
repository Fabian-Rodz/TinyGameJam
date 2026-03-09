extends CanvasLayer

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_map"):
		toggle_pause()

func toggle_pause() -> void:
	var paused := !get_tree().paused
	get_tree().paused = paused
	visible = paused

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false
