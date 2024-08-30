extends AnimatedSprite2D

@export var fart_duration: float = 0.5  # Duration of the "fart" animation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Handle animation switching
	if Input.is_action_just_pressed("ui_select"):  # Example input for shooting
		play_shoot_animation()
	elif not is_playing() or animation != "fart":
		play("idle")  # Play idle if no other animation is playing or currently playing shoot

# Function to play the fart animation
func play_shoot_animation() -> void:
	play("fart")
	await get_tree().create_timer(fart_duration).timeout
	play("idle")  # Return to idle after the shoot animation is done
