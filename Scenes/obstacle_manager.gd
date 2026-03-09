extends Node2D
@export var food_scene: PackedScene
@export var obstacle_scene: PackedScene
@export var spawn_offset: Vector2 = Vector2(900, 40)
@export var min_spawn_time: float = 1
@export var max_spawn_time: float = 2

@onready var spawn_points = $"../SpawnPoints".get_children()
@onready var timer: Timer = $Timer
@onready var start_timer: Timer = $"../StartTimer"

var spawn_enabled = false

func _ready() -> void:

	timer.start()

func _on_timer_timeout() -> void:
	spawn_obstacle()
	_set_next_spawn_time()
	timer.start()

func spawn_obstacle() -> void:
	if spawn_enabled:
		var who_spawns= randi_range(1,3)
		print(who_spawns)
		if obstacle_scene == null or food_scene == null:
			print("Obstacle or food scene not assigned!")
			return

		if spawn_points.size() < 2:
			print("Need at least 2 spawn points!")
			return

		var lanes = spawn_points.duplicate()
		lanes.shuffle()

		var obstacle_lane = lanes[0]
		var food_lane = lanes[1]

		var obstacle = obstacle_scene.instantiate()
		if who_spawns!=1:
			get_tree().current_scene.add_child(obstacle)
			obstacle.global_position = obstacle_lane.global_position + spawn_offset
			print("Obstacle final pos:", obstacle.global_position)
		if who_spawns!=2:
			var food = food_scene.instantiate()
			get_tree().current_scene.add_child(food)
			food.global_position = food_lane.global_position + spawn_offset
			print("Food final pos:", food.global_position)


func _set_next_spawn_time() -> void:
	timer.wait_time = randf_range(min_spawn_time, max_spawn_time)


func _on_start_timer_timeout() -> void:
	spawn_enabled = true

#
#func _ready() -> void:
	#randomize()
	#_set_next_spawn_time()
	#foodtimer.start()
	#timer.start()
#
#func _on_timer_timeout() -> void:
	#spawn_obstacle()
	#_set_next_spawn_time()
	#timer.start()
#
#func spawn_obstacle() -> void:
	#if obstacle_scene == null:
		#print("Obstacle scene not assigned!")
		#return
#
	#if spawn_points.is_empty():
		#print("No spawn points found!")
		#return
#
	#var obstacle = obstacle_scene.instantiate()
	#var lane = spawn_points.pick_random()
#
	#obstacle.global_position = lane.global_position + spawn_offset
	#print("Obstacle final pos:", obstacle.global_position)
	#get_tree().current_scene.add_child(obstacle)
#
#
#func spawn_food() -> void:
#
	#print("spawn_food called")
	#print("food_scene inside spawn_food:", food_scene)
#
	#if food_scene == null:
		#print("Food scene not assigned!")
		#return
#
	#if spawn_points.is_empty():
		#print("No spawn points found!")
		#return
#
	#var available_lanes = spawn_points.duplicate()
	#
#
	#if available_lanes.is_empty():
		#print("No free lane for food!")
		#return
#
	#var food = food_scene.instantiate()
	#var lane = available_lanes.pick_random()
#
	#food.global_position = lane.global_position + spawn_offset
	#print("Food final pos:", food.global_position)
#
	#get_tree().current_scene.add_child(food)
#func _set_next_spawn_time() -> void:
	#timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
#func _set_next_spawn_time_food() -> void:
	#foodtimer.wait_time = randf_range(min_spawn_time, max_spawn_time)
#
#
#func _on_timer_2_timeout() -> void:
	#spawn_food()
	#_set_next_spawn_time()
	#foodtimer.start()
