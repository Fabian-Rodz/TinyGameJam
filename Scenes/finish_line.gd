extends Node2D

@export var finish_line_scene: PackedScene
@export var spawn_position: Vector2 = Vector2(2500, 550)

@onready var finish_timer: Timer = $finishTimer

func _ready() -> void:
	print("Finish line spawner ready")

func _on_finish_timer_timeout() -> void:
	print("FINISH TIMER DONE")
	spawn_finish_line()

func spawn_finish_line() -> void:
	if finish_line_scene == null:
		print("Finish line scene not assigned!")
		return

	var finish = finish_line_scene.instantiate()
	finish.global_position = spawn_position
	add_child(finish)

	print("Finish line spawned!")
