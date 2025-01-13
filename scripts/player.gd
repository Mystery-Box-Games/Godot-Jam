extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 20

var character_direction : Vector2


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		
	character_direction.x = Input.get_axis("ui_left", "ui_right")
	character_direction.y = Input.get_axis("ui_up", "ui_down")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if character_direction:
		var current_rotation = $".".rotation
		var target_rotation = atan2(velocity.x, -velocity.y)
		
		$".".rotation = lerp_angle(current_rotation, target_rotation, ROTATION_SPEED * delta)
		velocity = (character_direction.normalized()) * SPEED
		
		
		#velocity = character_direction * SPEED
		#$".".rotation = atan2(velocity.x, -velocity.y)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
