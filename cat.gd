extends AnimatedSprite2D

signal velocity_change(new_velocity: Vector2)

@export var x_speed = 0
@export var y_speed = 0

@export var top_right_corner: Marker2D
@export var bottom_left_corner: Marker2D

var corner_dist = 100

var basic_states = ["clean",
	"walk",
	"idle",
	"sleep",
	"sleep",
]

var mouse_states = [
	"idle",
	"paw",
	"hiss",
	"walk"
]


var current_state = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	#DisplayServer.window_set_mouse_passthrough($Polygon2D.polygon)
	play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if current_state == "walk":
		pass


func get_velocity():
	return Vector2(x_speed, y_speed)

#
## Cat Actions 
#

func cat_action(action: String):
	match action:
		"clean":
			play("clean")
		"walk":
			play("walk")
		"paw":
			play("paw")
		"hiss":
			play("hiss")
		"pouce":
			play("pounce")
		"jump":
			play("jump")
		"sleep":
			play("sleep")
		_:
			play("default")

func _on_timer_timeout():
	
	# set action
	basic_states.shuffle()
	var new_action = basic_states[0]
	print("new state: ", new_action)
	if new_action == "walk":
		# set speed
		var x_neg = -1 * randi_range(-1, 1)
		x_speed = randi_range(1, 2) * ((randi() & 2) - 1)
		y_speed = randi_range(-2, 2)
		
		if global_position.x < bottom_left_corner.global_position.x + corner_dist:
			x_speed = 2
		elif global_position.x > top_right_corner.global_position.x - corner_dist:
			x_speed = -2
		
		if global_position.y > bottom_left_corner.global_position.y - corner_dist:
			y_speed = -2
		elif global_position.y < top_right_corner.global_position.y + corner_dist:
			y_speed = 2
		
		if x_speed < 0:
			flip_h = true
		else:
			flip_h = false
		
	else:
		x_speed = 0
		y_speed = 0
	velocity_change.emit(Vector2(x_speed, y_speed))
		
	current_state = new_action
	cat_action(new_action)
	
	# reset timer
	$BasicTimer.wait_time = randi_range(5, 10)
	$BasicTimer.start()


func _on_mouse_timer_timeout():
	# set action
	mouse_states.shuffle()
	var new_action = mouse_states[0]
	print("new state: ", new_action)
	if new_action == "walk":
		# set speed
		var x_neg = -1 * randi_range(-1, 1)
		x_speed = randi_range(1, 2) * ((randi() & 2) - 1)
		y_speed = randi_range(-2, 2)
		
		if global_position.x < bottom_left_corner.global_position.x + corner_dist:
			x_speed = 2
		elif global_position.x > top_right_corner.global_position.x - corner_dist:
			x_speed = -2
		
		if global_position.y > bottom_left_corner.global_position.y - corner_dist:
			y_speed = -2
		elif global_position.y < top_right_corner.global_position.y + corner_dist:
			y_speed = 2
		
		if x_speed < 0:
			flip_h = true
		else:
			flip_h = false
		
	else:
		x_speed = 0
		y_speed = 0
		flip_h = get_viewport().get_mouse_position().x < global_position.x
		
	velocity_change.emit(Vector2(x_speed, y_speed))
		
	current_state = new_action
	cat_action(new_action)
	
	# reset timer
	$MouseTimer.wait_time = randi_range(5, 10)
	$MouseTimer.start()


func _on_area_2d_mouse_entered():
	$BasicTimer.stop()
	_on_mouse_timer_timeout()


func _on_area_2d_mouse_exited():
	$MouseTimer.stop()
	_on_timer_timeout()
