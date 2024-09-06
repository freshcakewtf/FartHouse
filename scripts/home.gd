extends Control

# Preload the main scene to use later
var main_scene = preload("res://scenes/start.tscn")  # Replace with the actual path to your main scene

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var scene = ResourceLoader.load("res://scenes/start.tscn")
		if scene:
			get_tree().change_scene_to_packed(scene)
		else:
			print("Error: Failed to load scene.")
