extends CharacterBody2D  # Use CharacterBody2D for collision detection

# Movement speed of the player
@export var speed: float = 800
@export var shoot_duration: float = 0.5 # Duration of the "shoot" animation

# Define the boundaries (adjust as needed)
const BOUNDARY_LEFT: float = 0
const BOUNDARY_RIGHT: float = 1920
const BOUNDARY_TOP: float = 0
const BOUNDARY_BOTTOM: float = 1080

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	# Handle movement using physics
	var input_vector = Vector2()

	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1

	# Normalize the input vector to ensure consistent movement speed
	input_vector = input_vector.normalized()

	# Set the velocity based on the input
	velocity = input_vector * speed

	# Move the player based on the velocity and detect collisions
	move_and_slide()  # Handles movement and collision

	# Clamp the position to stay within the boundaries
	position.x = clamp(position.x, BOUNDARY_LEFT, BOUNDARY_RIGHT)
	position.y = clamp(position.y, BOUNDARY_TOP, BOUNDARY_BOTTOM)

	# Handle animation switching
	if Input.is_action_just_pressed("ui_select"):  # Example input for shooting
		play_shoot_animation()
	elif not $Player.is_playing() or $Player.animation != "shoot":
		$Player.play("idle")  # Play idle if no other animation is playing or currently playing shoot

# Function to handle the shoot animation
func play_shoot_animation() -> void:
	if $Player:  # Ensure the Player node exists
		$Player.play("shoot")
		await get_tree().create_timer(shoot_duration).timeout
		$Player.play("idle") # Return to idle after the shoot animation is done
