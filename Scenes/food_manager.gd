extends Node2D
@export var food_scene: PackedScene

@export var spawn_offset: Vector2 = Vector2(900, 40)
@export var min_spawn_time: float = 1
@export var max_spawn_time: float = 3

@onready var spawn_points = $"../SpawnPoints".get_children()

@onready var foodtimer: Timer = $Timer2

func _ready() -> void:
	randomize()
	_set_next_spawn_time_food()
	foodtimer.start()


func _on_timer_timeout() -> void:
	spawn_food()
	_set_next_spawn_time_food()
	foodtimer.start()



func spawn_food() -> void:

	print("spawn_food called")
	print("food_scene inside spawn_food:", food_scene)

	if food_scene == null:
		print("Food scene not assigned!")
		return

	if spawn_points.is_empty():
		print("No spawn points found!")
		return

	var available_lanes = spawn_points.duplicate()


	if available_lanes.is_empty():
		print("No free lane for food!")
		return

	var food = food_scene.instantiate()
	var lane = available_lanes.pick_random()

	food.global_position = lane.global_position + spawn_offset
	print("Food final pos:", food.global_position)

	get_tree().current_scene.add_child(food)

func _set_next_spawn_time_food() -> void:
	foodtimer.wait_time = randf_range(min_spawn_time, max_spawn_time)


func _on_timer_2_timeout() -> void:
	spawn_food()
	_set_next_spawn_time_food()
	foodtimer.start()
