extends Node2D

var enemy = preload("res://scenes/enemy.tscn")
var enemy_spawned = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!enemy_spawned):
		var instance = enemy.instantiate()
		add_child(instance)
		enemy_spawned = true
