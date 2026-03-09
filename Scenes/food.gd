extends Area2D

@export var speed: float = 250.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var food_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = food_types.pick_random()
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(-speed * delta, 0)

	if global_position.x < -40:
		queue_free()
	#queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	queue_free()
