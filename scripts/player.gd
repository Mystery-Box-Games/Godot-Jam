extends CharacterBody2D


const SPEED = 3
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 20

var character_direction : Vector2

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if character_direction.x > 0:
		animated_sprite.flip_h = false
	elif character_direction.x < 0:
		animated_sprite.flip_h = true
	
	if character_direction:
		var current_rotation = rotation
		var target_rotation = atan2(velocity.x, -velocity.y)
		
		#rotation = lerp_angle(current_rotation, target_rotation, ROTATION_SPEED * delta)
		#velocity = (character_direction.normalized()) * SPEED
		move_and_collide(character_direction.normalized() * SPEED)
		
		
		#velocity = character_direction * SPEED
		#$".".rotation = atan2(velocity.x, -velocity.y)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
	# Animations
	if character_direction == Vector2.ZERO:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")

	move_and_slide()
