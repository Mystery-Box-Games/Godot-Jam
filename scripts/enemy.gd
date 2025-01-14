extends CharacterBody2D

const SPEED = 200

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Change color for now
	animated_sprite.modulate = Color(1, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	
	
	# move towards player
	if (is_instance_valid(player)):
		var direction = (player.position - position).normalized()
		look_at(player.position)
		velocity = direction * SPEED
	move_and_slide()
	pass
