extends AnimatedSprite2D

@export var fart_duration: float = 0.5  # Duration of the "fart" animation
@export var shoot_sound : AudioStreamPlayer2D

func _ready() -> void:
	# Get the AudioStreamPlayer node if not set in the Inspector
	if shoot_sound == null:
		shoot_sound = $shootsound

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):  # "ui_select" is mapped to the input action for shooting
		shoot()

func _process(_delta: float) -> void:
	# Handle animation switching
	if Input.is_action_just_pressed("ui_select"):  # Example input for shooting
		play_shoot_animation()
	elif not is_playing() or animation != "fart":
		play("idle")  # Play idle if no other animation is playing or currently playing shoot

func play_shoot_animation() -> void:
	play("fart")
	await(get_tree().create_timer(fart_duration).timeout)
	play("idle")  # Return to idle after the shoot animation is done

func shoot() -> void:
	# Play the shoot sound effect
	if shoot_sound:
		shoot_sound.play()
