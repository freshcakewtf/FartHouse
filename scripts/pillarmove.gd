extends Node2D

var initial_x = 2000  # The initial x position of the first pillar
var min_y = 150  # Minimum y position for the pillar
var max_y = 900  # Maximum y position for the pillar
var speed_increment = 10  # The amount by which the speed will increase
var max_speed = 500  # Optional: Set a maximum speed to prevent it from getting too fast

var speed = 80  # Initial speed of the pillars
var min_distance = 1000  # Minimum distance between pillars

var pillars = []  # Array to store all pillar nodes

func _ready():
	# Initialize pillars array with references to each pillar node
	pillars = [$"../Pillar_01", $"../Pillar_02", $"../Pillar_03"]

	# Set initial positions for all pillars
	for i in range(pillars.size()):
		var pillar = pillars[i]
		pillar.position.x = initial_x + (i * min_distance)  # Spread out initial positions
		pillar.position.y = randi() % (max_y - min_y) + min_y

func _process(delta):
	for i in range(pillars.size()):
		var pillar = pillars[i]
		# Move the pillar to the left
		pillar.position.x -= speed * delta

		# Check if the pillar has moved off-screen
		if pillar.position.x < -100:  # Adjust this value according to your pillar's width
			reset_pillar(i)
			reset_slime(i)
			increase_speed()

func reset_pillar(index):
	var pillar = pillars[index]
	var previous_index = (index - 1 + pillars.size()) % pillars.size()  # Index of the previous pillar in the cycle

	# Get the previous pillar in the cyclic order
	var previous_pillar = pillars[previous_index]

	# Set the position based on the previous pillar's position to maintain 1000 units distance
	pillar.position.x = previous_pillar.position.x + min_distance

	# Randomize the y position for variability
	pillar.position.y = randi() % (max_y - min_y) + min_y

func reset_slime(index):
	var pillar = pillars[index]
	# Reference the slime StaticBody2D node inside the pillar node
	var slime_reset = pillar.get_node("slime")
	var slime_anim_reset = slime_reset.get_node("slimeanimation")

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
