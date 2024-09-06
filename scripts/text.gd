extends Sprite2D

var speed = 100
var max_distance = -2000

func _process(delta):
	# Move the object to the left
	position.x -= speed * delta

	# Stop the object when it reaches the maximum distance
	if is_equal_approx(position.x, max_distance):
		speed = 0
