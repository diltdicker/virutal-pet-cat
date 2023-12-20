extends CharacterBody2D

@export var max_speed = 5
var cur_velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = cur_velocity
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#velocity = Vector2($Cat2.x_speed, $Cat2.y_speed) * max_speed


func _physics_process(delta):
	velocity = cur_velocity
	move_and_slide()



func _on_cat_2_velocity_change(new_velocity):
	print(new_velocity)
	cur_velocity = new_velocity * max_speed
