extends CharacterBody2D


const SPEED = 600.0
var crash_speed = 1000


var is_p1 = true
var is_hit = false;
var hit_counter = 0
var points = 0

@onready var sprite
@onready var red_animated_sprite_2d: AnimatedSprite2D = $RedAnimatedSprite2D
@onready var yellow_animated_sprite_2d: AnimatedSprite2D = $YellowAnimatedSprite2D
@onready var blue_animated_sprite_2d: AnimatedSprite2D = $BlueAnimatedSprite2D
@onready var green_animated_sprite_2d: AnimatedSprite2D = $GreenAnimatedSprite2D
@onready var car_collision: CollisionShape2D = $CarArea/CarCollision


# Car_States
enum Car_State{
	Startup,
	Running,
	Hit,
	Jumping
}

var current_state: Car_State = Car_State.Running

func change_state(newState):
	current_state = newState
	match current_state:
		Car_State.Startup:
			sprite.play("startup")
		Car_State.Running:
			sprite.play("running")
		Car_State.Hit:
			is_hit = true
			hit_counter = 0
			sprite.stop()
			crash_speed = 100
		Car_State.Jumping:
			car_collision.set_deferred("disabled",true)
			sprite.play("jump")

# Car Colors
enum Car_Color{
	Red,
	Yellow,
	Blue,
	Green
}
var color: Car_Color = Car_Color.Red

func change_color(newColor:Car_Color):
	color = newColor
	match color:
		Car_Color.Red:
			red_animated_sprite_2d.show()
			yellow_animated_sprite_2d.hide()
			blue_animated_sprite_2d.hide()
			green_animated_sprite_2d.hide()
			sprite = red_animated_sprite_2d
		Car_Color.Yellow:
			red_animated_sprite_2d.hide()
			yellow_animated_sprite_2d.show()
			blue_animated_sprite_2d.hide()
			green_animated_sprite_2d.hide()
			sprite = yellow_animated_sprite_2d
		Car_Color.Blue:
			red_animated_sprite_2d.hide()
			yellow_animated_sprite_2d.hide()
			blue_animated_sprite_2d.show()
			green_animated_sprite_2d.hide()
			sprite = blue_animated_sprite_2d
		Car_Color.Green:
			red_animated_sprite_2d.hide()
			yellow_animated_sprite_2d.hide()
			blue_animated_sprite_2d.hide()
			green_animated_sprite_2d.show()
			sprite = green_animated_sprite_2d


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
	
	change_state(Car_State.Startup)


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
	
	# State handling
	match current_state:
		Car_State.Startup:
			sprite.play("startup")
			velocity = Vector2.ZERO

		Car_State.Running:
			#if direction != Vector2.ZERO:
			velocity = velocity.move_toward(direction * SPEED, 100)
			#else:
				#velocity = velocity.move_toward(Vector2.ZERO,100)

		Car_State.Hit:
			if hit_counter < 4:
				velocity = velocity.move_toward(Vector2(-250,direction.y*SPEED*0.5),110)
				if not sprite.is_playing():
					sprite.play("hit")
					hit_counter += 1
			else:
				crash_speed = 1000
				is_hit = false
				change_state(Car_State.Running)

		Car_State.Jumping:
			velocity = Vector2(100,0)
			if not sprite.is_playing():
				car_collision.set_deferred("disabled",false)
				change_state(Car_State.Running)
	
	if Input.is_action_just_pressed("ui_cancel"):
		change_state(Car_State.Running)
	if Input.is_action_just_pressed("ui_accept"):
		change_state(Car_State.Jumping)

	move_and_slide()


func _on_car_area_area_entered(area: Area2D) -> void:
	if "Car" in area.name:
		var direction = (global_position - area.global_position).normalized() * crash_speed
		velocity = direction
		global_position.x = move_toward(global_position.x,global_position.x + direction.x,10)
		global_position.y = move_toward(global_position.y,global_position.y + direction.y,10)
	if "Obstacle" in area.name:
		change_state(Car_State.Hit)
	if "Food" in area.name:
		points += 1
		print("Points: " + str(points))
