extends CharacterBody2D


const SPEED = 600.0
const CRASH_SPEED = 1000


var is_p1 = true

@onready var sprite
@onready var red_animated_sprite_2d: AnimatedSprite2D = $RedAnimatedSprite2D
@onready var yellow_animated_sprite_2d: AnimatedSprite2D = $YellowAnimatedSprite2D
@onready var blue_animated_sprite_2d: AnimatedSprite2D = $BlueAnimatedSprite2D
@onready var green_animated_sprite_2d: AnimatedSprite2D = $GreenAnimatedSprite2D


enum Car_Color{
	Red,
	Yellow,
	Blue,
	Green
}
var color: Car_Color = Car_Color.Red

func _ready() -> void:
	match color:
		Car_Color.Red:
			sprite = red_animated_sprite_2d
		Car_Color.Yellow:
			sprite = yellow_animated_sprite_2d
		Car_Color.Blue:
			sprite = blue_animated_sprite_2d
		Car_Color.Green:
			sprite = green_animated_sprite_2d
	
	sprite.play("startup")


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2.ZERO
	
	# Set movement controls if player is p1 or p2
	if is_p1:
		direction.x = Input.get_axis("p1_back", "p1_forward")
		direction.y = Input.get_axis("p1_up","p1_down")
	else:
		direction.x = Input.get_axis("p2_back", "p2_forward")
		direction.y = Input.get_axis("p2_up","p2_down")
	
	# Movement
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * SPEED, 100)

	else:
		velocity = velocity.move_toward(Vector2.ZERO,100)


	move_and_slide()


func _on_car_area_area_entered(area: Area2D) -> void:
	var direction = (global_position - area.global_position).normalized() * CRASH_SPEED
	velocity = direction
	global_position.x = move_toward(global_position.x,global_position.x + direction.x,10)
	global_position.y = move_toward(global_position.y,global_position.y + direction.y,10)
