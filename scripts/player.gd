extends CharacterBody2D


const SPEED = 3
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 20

var sprite_idle = "mouse_idle"
var sprite_run = "mouse_run"

var character_direction : Vector2

@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager


func _physics_process(delta: float) -> void:

	# get direction from keyboard
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	
	# if character is moving, rotate it to that direction
	if character_direction:
		var current_rotation = rotation
		var target_rotation = atan2(velocity.x, -velocity.y)
		
		rotation = lerp_angle(current_rotation, target_rotation, ROTATION_SPEED * delta)
		velocity = (character_direction.normalized() * (SPEED * 100))
		
		#move_and_collide(character_direction.normalized() * SPEED)
		#velocity = character_direction * SPEED
		#$".".rotation = atan2(velocity.x, -velocity.y)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
	# Animations
	if character_direction == Vector2.ZERO:
		animated_sprite.play(sprite_idle)
	else:
		animated_sprite.play(sprite_run)

	move_and_slide()

func change_character(dice_roll: int) -> void:
	print("Dice rolled a ", dice_roll)
	
	match dice_roll:
		1: # mouse
			sprite_idle = "mouse_idle"
			sprite_run = "mouse_run"
		2: # snake
			sprite_idle = "snake_idle"
			sprite_run = "snake_run"
		3: #badger
			sprite_idle = "badger_idle"
			sprite_run = "badger_run"
		4: # crocodile
			sprite_idle = "crocodile_idle"
			sprite_run = "crocodile_run"
		5: # lion
			sprite_idle = "mouse_idle"
			sprite_run = "mouse_run"
		6: # bear
			sprite_idle = "mouse_idle"
			sprite_run = "mouse_run"
		_: # default
			sprite_idle = "mouse_idle"
			sprite_run = "mouse_run"
