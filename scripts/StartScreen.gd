extends Control

# Preload the main scene to use later
var main_scene = preload("res://scenes/main.tscn")  # Replace with the actual path to your main scene

func _input(event):
	# Check if the input action "ui_accept" (typically the "Enter" or "Space" key) is pressed
	if event.is_action_pressed("ui_accept"):
		# Change to the preloaded main scene
		get_tree().change_scene_to_packed(main_scene)
