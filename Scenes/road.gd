extends Node2D

@export var scroll_speed: float = 1000.0

@onready var road_1: Sprite2D = $Road1
@onready var road_2: Sprite2D = $Road2
@onready var finish_timer: Timer = $"finishTimer"
@onready var runtime: Label = $"GameManager/finishtime/finishTimeLabel"
func _ready() -> void:
	if road_1.texture == null or road_2.texture == null:
		print("Road1 or Road2 has no texture assigned!")
		return

	var road_width = road_1.texture.get_width() * road_1.scale.x

	road_1.position.x = 0
	road_2.position.x = road_width
	finish_timer.start()
	
	Global.stop_shared_music()
	$AudioStreamPlayer2D.play()
	

func _process(delta: float) -> void:
	_update_time_label()
	if road_1.texture == null or road_2.texture == null:
		return

	var road_width = road_1.texture.get_width() * road_1.scale.x

	road_1.position.x -= scroll_speed * delta
	road_2.position.x -= scroll_speed * delta

	if road_1.position.x <= -road_width:
		road_1.position.x = road_2.position.x + road_width

	if road_2.position.x <= -road_width:
		road_2.position.x = road_1.position.x + road_width
func _update_time_label() -> void:
	if finish_timer!=null:
		
		var seconds_left := int(ceil(finish_timer.time_left))
		if seconds_left<=60:
			runtime.text = "Time Left: %d" % seconds_left + "s"
		else:
			runtime.text = ""
			

func _on_finish_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/End_screen.tscn")
