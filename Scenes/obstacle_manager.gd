extends Node2D
@export var food_scene: PackedScene
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
	spawn_food(lane)

func spawn_food(used_lane) -> void:

	print("spawn_food called")
	print("food_scene inside spawn_food:", food_scene)

	if food_scene == null:
		print("Food scene not assigned!")
		return

	if spawn_points.is_empty():
		print("No spawn points found!")
		return

	var available_lanes = spawn_points.duplicate()
	available_lanes.erase(used_lane)

	if available_lanes.is_empty():
		print("No free lane for food!")
		return

	var food = food_scene.instantiate()
	var lane = available_lanes.pick_random()

	food.global_position = lane.global_position + spawn_offset
	get_tree().current_scene.add_child(food)
func _set_next_spawn_time() -> void:
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	
