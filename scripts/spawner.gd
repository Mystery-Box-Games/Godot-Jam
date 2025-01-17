extends Node2D

var enemy = preload("res://scenes/enemy.tscn")
var enemy_spawned = false
#@onready var game: Node2D = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	add_to_group("spawners") # Replace with function body.


func spawn_enemy():
	var instance = enemy.instantiate()
	instance.add_to_group("enemies")
	add_child(instance)
