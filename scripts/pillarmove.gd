extends Node2D

var speed = 200  # Initial speed of the pillars
var initial_x = 2000  # The initial x position of the pillar, adjust as needed
var min_y = 100  # Minimum y position for the pillar
var max_y = 400  # Maximum y position for the pillar
var speed_increment = 25  # The amount by which the speed will increase
var max_speed = 5000  # Optional: Set a maximum speed to prevent it from getting too fast

func _process(delta):
	# Move the pillar to the left
	position.x -= speed * delta

	# Check if the pillar has moved off-screen
	if position.x < -1080:  # Adjust this value according to your pillar's width
		# Reset the position of the pillar
		reset_pillar()
		reset_slime()
		# Increase the speed after each reset
		increase_speed()

func reset_pillar():
	# Reset the pillar's x position to the starting point
	position.x = initial_x
	# Randomize the y position for variability
	position.y = randi() % (max_y - min_y) + min_y

func reset_slime():
	# Reference the slime StaticBody2D node
	var slime_reset = $slime
	var slime_anim_reset = $slime/slimeanimation
	
	# Ensure it's a valid StaticBody2D or similar physics body
	if slime_reset and slime_reset is StaticBody2D:
		# Set collision layer to 9 (bitmask: 1 << 8)
		slime_reset.collision_layer = 1 << 8
		slime_anim_reset.play("default")
	else:
		print("Error: Slime node is not found or not a StaticBody2D")

func increase_speed():
	# Increase the speed of the pillar movement
	if speed < max_speed:  # Optional: cap the speed at max_speed
		speed += speed_increment
