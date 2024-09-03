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
		reset_bean()
		reset_vis()
		increase_speed()

func reset_bean():
	# Reset the pillar's x position to the starting point
	position.x = initial_x + speed_increment
	# Randomize the y position for variability
	position.y = randi() % (max_y - min_y) + min_y

func reset_vis():
	$".".visible = true

func increase_speed():
	# Increase the speed of the pillar movement
	if speed < max_speed:  # Optional: cap the speed at max_speed
		speed += speed_increment
