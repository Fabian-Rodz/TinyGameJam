extends CharacterBody2D


const SPEED = 600.0
@onready var sprite: Sprite2D = $Sprite2D

var is_p1 = true

func _ready() -> void:
	sprite.modulate = Color.DARK_RED

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var h_direction
	var v_direction
	
	# Set movement controls if player is p1 or p2
	if is_p1:
		h_direction = Input.get_axis("p1_back", "p1_forward")
		v_direction = Input.get_axis("p1_up","p1_down")
	else:
		h_direction = Input.get_axis("p2_back", "p2_forward")
		v_direction = Input.get_axis("p2_up","p2_down")
	
	# Horizontal Movement
	if h_direction:
		velocity.x = h_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Vertical Movement
	if v_direction:
		velocity.y = v_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
