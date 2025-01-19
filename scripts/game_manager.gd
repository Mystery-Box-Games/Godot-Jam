extends Node

var dice_roll = 1;

@onready var dice_timer: Timer = $DiceTimer
@onready var spawn_timer: Timer = $SpawnTimer
@onready var player: CharacterBody2D = $"../Player"
@onready var game_over_ui: ColorRect = $"../UI/GameOverUI"
@onready var ui_timer: Label = $"../UI/UITimer"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ui_timer.text = "Change In: %ss" % int(dice_timer.get_time_left() + 1)

func game_over() -> void:
	player.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_ui.visible = true

func _on_spawn_timer_timeout() -> void:
	get_tree().call_group("spawners", "spawn_enemy")


func _on_dice_timer_timeout() -> void:
	# Pause game
	
	# roll dice
	dice_roll = randi() % 6 + 1
	
	# change character
	player.change_character(dice_roll)
	
	pass
