extends CharacterBody2D


const BOOST = 4000
const ROTATION_SPEED = 20

var health = 100
var speed = 3
var invincibility = .2
var sprite_idle = "mouse_idle"
var sprite_run = "mouse_run"
var sprite_attack = ""
var can_attack = true
var attacking = false
var taking_damage = false
var dice_roll = 1

var character_direction : Vector2

var percentage_of_time

@onready var health_bar: TextureProgressBar = $"../UI/HealthBar"
@onready var attack_bar: TextureProgressBar = $"../UI/AttackBar"
@onready var attack_timer: Timer = $AttackTimer

@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var mouse_collision: CollisionShape2D = $Hurtzone/mouse_collision
@onready var snake_collision: CollisionShape2D = $Hurtzone/snake_collision
@onready var badger_collision: CollisionShape2D = $Hurtzone/badger_collision
@onready var crocodile_collision: CollisionShape2D = $Hurtzone/crocodile_collision
@onready var lion_collision: CollisionShape2D = $Hurtzone/lion_collision
@onready var bear_collision: CollisionShape2D = $Hurtzone/bear_collision

@onready var mouse_collisionMain: CollisionShape2D = $mouse_collision
@onready var snake_collisionMain: CollisionShape2D = $snake_collision
@onready var badger_collisionMain: CollisionShape2D = $badger_collision
@onready var crocodile_collisionMain: CollisionShape2D = $crocodile_collision
@onready var lion_collisionMain: CollisionShape2D = $lion_collision
@onready var bear_collisionMain: CollisionShape2D = $bear_collision


func _ready() -> void:
	#disable collision boxes
	snake_collision.disabled = true
	badger_collision.disabled = true
	crocodile_collision.disabled = true
	lion_collision.disabled = true
	bear_collision.disabled = true
	
	snake_collisionMain.disabled = true
	badger_collisionMain.disabled = true
	crocodile_collisionMain.disabled = true
	lion_collisionMain.disabled = true
	bear_collisionMain.disabled = true

func _physics_process(delta: float) -> void:
	health = clamp(health, 0, 100)
	health_bar.value = health
	
	if (health <= 0):
		set_process_input(false)
		game_manager.game_over()
	
	if attack_timer.get_time_left() > 0:
		percentage_of_time = ((1 - attack_timer.get_time_left() / attack_timer.get_wait_time()) * 100)
		var use_int = int(percentage_of_time)
		attack_bar.value = percentage_of_time

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
	if character_direction == Vector2.ZERO && !attacking:
		animated_sprite.play(sprite_idle)
	elif attacking:
		animated_sprite.play(sprite_attack)
	else:
		animated_sprite.play(sprite_run)
	
	attack()
	move_and_slide()

func change_character(new_roll: int) -> void:
	dice_roll = new_roll
	print("Dice rolled a ", dice_roll)
	
	match dice_roll:
		1: # mouse
			
			# speed
			speed = 3
			
			sprite_idle = "mouse_idle"
			sprite_run = "mouse_run"
			sprite_attack = ""
			
			# enable collision
			mouse_collision.disabled = false
			mouse_collisionMain.disabled = false
			
			# disable all other collision
			snake_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
			
			snake_collisionMain.disabled = true
			badger_collisionMain.disabled = true
			crocodile_collisionMain.disabled = true
			lion_collisionMain.disabled = true
			bear_collisionMain.disabled = true
	
		2: # snake
			
			# speed
			speed = 2.5
			
			sprite_idle = "snake_idle"
			sprite_run = "snake_run"
			sprite_attack = ""
			
			# enable collision
			snake_collision.disabled = false
			snake_collisionMain.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
			
			mouse_collisionMain.disabled = true
			badger_collisionMain.disabled = true
			crocodile_collisionMain.disabled = true
			lion_collisionMain.disabled = true
			bear_collisionMain.disabled = true
			
		3: #badger
			
			#speed
			speed = 2
			
			sprite_idle = "badger_idle"
			sprite_run = "badger_run"
			sprite_attack = ""
			
			# enable collision
			badger_collision.disabled = false
			badger_collisionMain.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			snake_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
			
			mouse_collisionMain.disabled = true
			snake_collisionMain.disabled = true
			crocodile_collisionMain.disabled = true
			lion_collisionMain.disabled = true
			bear_collisionMain.disabled = true
			
		4: # crocodile
			
			# speed
			speed = 1.5
			
			sprite_idle = "crocodile_idle"
			sprite_run = "crocodile_run"
			sprite_attack = ""
			
			# scale up cause he's too small
			#scale = Vector2(5, 5)
			
			# enable collision
			crocodile_collision.disabled = false
			crocodile_collisionMain.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			snake_collision.disabled = true
			badger_collision.disabled = true
			lion_collision.disabled = true
			bear_collision.disabled = true
			
			mouse_collisionMain.disabled = true
			snake_collisionMain.disabled = true
			badger_collisionMain.disabled = true
			lion_collisionMain.disabled = true
			bear_collisionMain.disabled = true
			
		5: # lion
			
			# speed
			speed = 1.5
			
			sprite_idle = "lion_idle"
			sprite_run = "lion_run"
			sprite_attack = "lion_attack"
			
			# enable collision
			lion_collision.disabled = false
			lion_collisionMain.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			snake_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			bear_collision.disabled = true
			
			mouse_collisionMain.disabled = true
			snake_collisionMain.disabled = true
			badger_collisionMain.disabled = true
			crocodile_collisionMain.disabled = true
			bear_collisionMain.disabled = true
			
		6: # bear
			
			#speed
			speed = .8
			
			sprite_idle = "bear_idle"
			sprite_run = "bear_run"
			sprite_attack = "bear_attack"
			
			# enable collision
			bear_collision.disabled = false
			bear_collisionMain.disabled = false
			
			# disable all other collision
			mouse_collision.disabled = true
			snake_collision.disabled = true
			badger_collision.disabled = true
			crocodile_collision.disabled = true
			lion_collision.disabled = true
			
			mouse_collisionMain.disabled = true
			snake_collisionMain.disabled = true
			badger_collisionMain.disabled = true
			crocodile_collisionMain.disabled = true
			lion_collisionMain.disabled = true
			
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

func take_damage() -> void:
	health -= 5
	await get_tree().create_timer(invincibility).timeout
	taking_damage = false

func attack() -> void:
	if Input.is_action_pressed("attack") && can_attack:
		can_attack = false
		print("attacking")
		var time
		match dice_roll:
			1: # mouse
				velocity = (character_direction.normalized() * (BOOST))
				
				# wait time
				time = 2
			2: # snake
				# lunge foward, attack
				velocity = (character_direction.normalized() * (2000))
				attacking = true
				await get_tree().create_timer(.1).timeout
				attacking = false
				
				time = 1.9
			3: # badger
				velocity = (character_direction.normalized() * (2000))
				attacking = true
				await get_tree().create_timer(.1).timeout
				attacking = false
				
				# wait time
				time = 1
			4: # crocodile
				velocity = (character_direction.normalized() * (2000))
				attacking = true
				await get_tree().create_timer(.1).timeout
				attacking = false
				
				# wait time
				time = 1.5
			5: # lion
				velocity = (character_direction.normalized() * (2000))
				attacking = true
				#await get_tree().create_timer(.1).timeout
				#attacking = false
				
				# wait time
				time = 1
			6: # bear
				#velocity = (character_direction.normalized() * (2000))
				attacking = true
				
				# wait time
				time = .5
		
		#await get_tree().create_timer(time).timeout
		attack_timer.start(time)
		

func _on_attack_timer_timeout() -> void:
	attack_bar.value = 100
	can_attack = true
	

func _on_attackzone_body_entered(body: Node2D) -> void:
	if body is Enemy && attacking:
		body.attack(100)


func _on_hurtzone_body_entered(body: Node2D) -> void:
	if body is Enemy && !taking_damage:
		taking_damage = true
		take_damage()


func _on_animated_sprite_2d_animation_finished() -> void:
	if (animated_sprite.animation == sprite_attack):
		attacking = false
		
