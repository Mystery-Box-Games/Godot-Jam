extends CharacterBody2D

const SPEED = 2
const min_distance = 50;

var player_position
var target_position

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Change color for now
	animated_sprite.modulate = Color(1, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	player_position = player.global_position
	target_position = (player_position - global_position).normalized()
	if (global_position.distance_to(player_position) > min_distance):
		move_and_collide(target_position * SPEED)
	look_at(player_position)
