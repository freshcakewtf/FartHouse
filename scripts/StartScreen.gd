extends Control

# Preload the main scene to use later
var main_scene = preload("res://scenes/main.tscn")  # Replace with the actual path to your main scene

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if main_scene:
			get_tree().change_scene_to_packed(main_scene)
		else:
			print("Error: main_scene is not loaded properly.")
