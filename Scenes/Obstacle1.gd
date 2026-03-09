extends CharacterBody2D

@export var speed: float = 1000.0

func _physics_process(_delta: float) -> void:
	velocity = Vector2(-speed, 0)
	move_and_slide()

	if global_position.x < -700:
		queue_free()
