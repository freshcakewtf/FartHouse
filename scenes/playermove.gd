extends Sprite2D

# Movement speed of the player
var speed = 800

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the input from the arrow keys
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

	# Move the player based on the input
	position += input_vector * speed * delta
