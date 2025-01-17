extends Node

@onready var spawn_timer: Timer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	get_tree().call_group("spawners", "spawn_enemy")


func _on_dice_timer_timeout() -> void:
	# Pause game, roll dice, change character
	pass
