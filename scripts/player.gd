extends CharacterBody2D



const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 20

var speed = 3
var sprite_idle = "mouse_idle"
var sprite_run = "mouse_run"

var character_direction : Vector2

@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var mouse_collision: CollisionShape2D = $mouse_collision
@onready var snake_collision: CollisionShape2D = $snake_collision
@onready var badger_collision: CollisionShape2D = $badger_collision
@onready var crocodile_collision: CollisionShape2D = $crocodile_collision
@onready var lion_collision: CollisionShape2D = $lion_collision
@onready var bear_collision: CollisionShape2D = $bear_collision

func _ready() -> void:
	#disable collision boxes
	snake_collision.disabled = true
	badger_collision.disabled = true
	crocodile_collision.disabled = true
	lion_collision.disabled = true
	bear_collision.disabled = true

func _physics_process(delta: float) -> void:

	# get direction from keyboard
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	
	# if character is moving, rotate it to that direction
	if character_direction:
		var current_rotation = rotation
		var target_rotation = atan2(velocity.x, -velocity.y)
		
		rotation = lerp_angle(current_rotation, target_rotation, ROTATION_SPEED * delta)
		velocity = (character_direction.normalized() * (speed * 100))
		
		#move_and_collide(character_direction.normalized() * SPEED)
		#velocity = character_direction * SPEED
		#$".".rotation = atan2(velocity.x, -velocity.y)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		
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
			
			# speed
			speed = 3
			
			sprite_idle = "mouse_idle"
			sprite_run = "mouse_run"
			
			# enable collision
			mouse_collision.disabled = false
			
			# disable all other collision
			snake_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
	
		2: # snake
			
			# speed
			speed = 2.5
			
			sprite_idle = "snake_idle"
			sprite_run = "snake_run"
			
			# enable collision
			snake_collision.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
			
		3: #badger
			
			#speed
			speed = 2
			
			sprite_idle = "badger_idle"
			sprite_run = "badger_run"
			
			# enable collision
			badger_collision.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			snake_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
			
		4: # crocodile
			
			# speed
			speed = 1.5
			
			sprite_idle = "crocodile_idle"
			sprite_run = "crocodile_run"
			
			# scale up cause he's too small
			#scale = Vector2(5, 5)
			
			# enable collision
			crocodile_collision.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			snake_collision.disabled = true
			badger_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
			
		5: # lion
			
			# speed
			speed = 1.5
			
			sprite_idle = "lion_idle"
			sprite_run = "lion_run"
			
			# enable collision
			lion_collision.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			snake_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			bear_collision.disabled = true
			
		6: # bear
			
			#speed
			speed = .5
			
			sprite_idle = "mouse_idle"
			sprite_run = "mouse_run"
			
			# enable collision
			bear_collision.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			snake_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			
		_: # default
			sprite_idle = "mouse_idle"
			sprite_run = "mouse_run"
			
			# enable collision
			mouse_collision.disabled = false
			
			# disable all other collision
			snake_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
