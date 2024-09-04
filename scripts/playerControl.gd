extends CharacterBody2D

@export var speed: float = 800
@export var shoot_duration: float = 0.5 # animation Duration
@export var rotation_speed: float = 2.0  # Speed at which the character rotates up/down
@export var easing_speed: float = 12.0  # Speed at which the character rotates back to zero

const BOUNDARY_LEFT: float = 0
const BOUNDARY_RIGHT: float = 1920
const BOUNDARY_TOP: float = 0
const BOUNDARY_BOTTOM: float = 1080

var score = 0  # Initialize a score variable
@onready var pointsLabel = $"../Can/Points"

func _ready() -> void:
	update_score(0)

func _physics_process(delta: float) -> void:
	# Handle movement using physics
	var input_vector = Vector2()

	# Movement input
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
		rotation -= rotation_speed * delta  # Rotate up
	elif Input.is_action_pressed("ui_down"):
		input_vector.y += 1
		rotation += rotation_speed * delta  # Rotate down
	else:
		# Ease the rotation back to 0.0 when no input is pressed, with adjustable speed
		rotation = lerp(rotation, 0.0, delta * easing_speed)

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

	# Point collection
	bean_point()
	

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
		$Player.play("idle")  # Return to idle after the shoot animation is done

	# Check collision with slime during shoot
	var player_shot_detect = $PlayershotDetect
	var overlapping_bodies = player_shot_detect.get_overlapping_bodies()

	if overlapping_bodies.size() > 0:
		print("Overlapping bodies: ", overlapping_bodies)
		for body in overlapping_bodies:
			# Ensure we're dealing with the "slime" object
			if body.name == "slime":
				print("Slime detected: Changing collision layer")
				# Ensure that you are accessing the correct node for slime
				body.collision_layer = 16  # Change slime's collision layer to allow player to pass through
				
				# Access the AnimationPlayer or AnimatedSprite node within slime
				var animation_node = body.get_node("slimeanimation")  # Change "slimeanimation" to the actual path to the node
				if animation_node:
					animation_node.play("dead")  # Play the destroy animation
				else:
					print("Animation node not found in slime")

func bean_point():
	var bean_collision = $beanCollect
	var bean_overlap = bean_collision.get_overlapping_bodies()
	var bean_sound = $beanCollect/beanSound
	var bean_can = $"../Can"
	
	if bean_overlap.size() > 0:
		for body in bean_overlap:
			if body.name == "bean":
				if body.visible:  # Check if the bean is currently visible
					body.visible = false
					bean_sound.play()
					bean_can.play("cashIn")
					score += 1 * 10
					print("Score updated to: ", score)  # Debug line to see score update
					update_score(score)  # Call this to update the score label

func update_score(score) -> void:
	if pointsLabel:
		pointsLabel.text = str(score)
	else:
		print("Points node not assigned or not found.")
