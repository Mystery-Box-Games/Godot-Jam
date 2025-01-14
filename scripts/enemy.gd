extends CharacterBody2D

const SPEED = 300

@onready var player := $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# move towards player
	#if (is_instance_valid(player)):
	#var direction = (player.position - position)/50
	#look_at(player.position)
	#velocity = direction * SPEED
	#move_and_slide()
	pass
