extends Control

@onready var options: ColorRect = $Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Button_Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")



func _on_button_quit_pressed() -> void:
	get_tree().quit()



func _on_button_options_pressed() -> void:
	options.visible = true


func _on_button_pressed() -> void:
	options.visible = false
