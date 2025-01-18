extends Node

var dice_roll = 1;

@onready var spawn_timer: Timer = $SpawnTimer
@onready var player: CharacterBody2D = $"../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	get_tree().call_group("spawners", "spawn_enemy")


func _on_dice_timer_timeout() -> void:
	# Pause game
	
	# roll dice
	#dice_roll = randi() % 6 + 1
	
	# change character
	player.change_character(2)
	
	pass
