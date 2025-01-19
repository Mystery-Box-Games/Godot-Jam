extends CharacterBody2D

class_name Enemy

const SPEED = 2
const min_distance = 5;

var health = 100

var player_position
var target_position

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_parent().get_parent().get_parent().get_node("Player")

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
	
	if (health <= 0): queue_free()
	
func change_color() -> void:
	animated_sprite.modulate = Color(0, 1, 0)
	
	get_tree().change_scene_to_file("res://scenes/player.tscn")

func attack(damage: int) -> void:
	health -= damage
