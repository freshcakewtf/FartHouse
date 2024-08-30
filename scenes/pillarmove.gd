extends Node2D

var speed = 200
var initial_x = 1280  # The initial x position of the pillar, adjust as needed
var min_y = 100  # Minimum y position for the pillar
var max_y = 400  # Maximum y position for the pillar

func _process(delta):
	# Move the pillar to the left
	position.x -= speed * delta

	# Check if the pillar has moved off-screen
	if position.x < -1080:  # Adjust this value according to your pillar's width
		# Reset the position of the pillar
		reset_pillar()

func reset_pillar():
	# Reset the pillar's x position to the starting point
	position.x = initial_x
	# Randomize the y position for variability
	position.y = randi() % (max_y - min_y) + min_y
