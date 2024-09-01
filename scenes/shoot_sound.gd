extends Node2D

@export var shoot_sound : AudioStreamPlayer2D

func _ready() -> void:
	# Ensure the AudioStreamPlayer2D node is set
	if shoot_sound == null:
		shoot_sound = $ShootSound

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):  # Trigger sound on "ui_select" input action
		play_sound()

func play_sound() -> void:
	# Play the shoot sound effect
	if shoot_sound:
		shoot_sound.play()
