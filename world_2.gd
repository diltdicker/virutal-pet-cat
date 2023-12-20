extends Node2D

@export var top_left : Marker2D
@export var top_right : Marker2D
@export var bottom_left : Marker2D
@export var bottom_right : Marker2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 0)
	
	#DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_MOUSE_PASSTHROUGH, true, 0)
	#DisplayServer.window_set_mouse_passthrough($Polygon2D.polygon, 0)
	#get_tree().get_root().set_transparent_background(true)
	#DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 0)
	
	#DisplayServer.window_set_flag(, true, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#DisplayServer.window_set_mouse_passthrough($Polygon2D.polygon, 0)
	var vec_2d_array = PackedVector2Array()
	vec_2d_array.append(top_left.global_position)
	vec_2d_array.append(top_right.global_position)
	vec_2d_array.append(bottom_right.global_position)
	vec_2d_array.append(bottom_left.global_position)
	#print(vec_2d_array)
	#var poly = $Cat2/Polygon2D.polygon
	#DisplayServer.window_set_mouse_passthrough(poly)
	DisplayServer.window_set_mouse_passthrough(vec_2d_array, 0)
	
