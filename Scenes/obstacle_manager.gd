extends Node2D

@export var obstacle_scene: PackedScene
@export var spawn_offset: Vector2 = Vector2(900, 40)
@export var min_spawn_time: float = 2.5
@export var max_spawn_time: float = 4.5

@onready var spawn_points = $"../SpawnPoints".get_children()
@onready var timer: Timer = $Timer

func _ready() -> void:
	randomize()
	_set_next_spawn_time()
	timer.start()

func _on_timer_timeout() -> void:
	spawn_obstacle()
	_set_next_spawn_time()
	timer.start()

func spawn_obstacle() -> void:
	if obstacle_scene == null:
		print("Obstacle scene not assigned!")
		return

	if spawn_points.is_empty():
		print("No spawn points found!")
		return

	var obstacle = obstacle_scene.instantiate()
	var lane = spawn_points.pick_random()

	obstacle.global_position = lane.global_position + spawn_offset
	get_tree().current_scene.add_child(obstacle)

func _set_next_spawn_time() -> void:
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
