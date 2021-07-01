extends Position3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var SENSITIVITY = 0.2
export var SMOOTHNESS = 10

onready var cam = $"y-gimbal/Camera"
var camera_input : Vector2
var rotation_velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		#camera input is a tuple of (x, y) movement
		camera_input = event.relative
		print(camera_input)


# Called every frame. 'delta' is the elapsed time since the previous frame.
var i = 1
func _process(delta):
	if(i >= 60):
		i = 0
		print($"../Pivot".rotation_degrees.z)
	else:
		i += 1
	var rotation_tuple = $'y-gimbal'.global_transform.basis.get_euler()
	rotation_velocity = rotation_velocity.linear_interpolate(camera_input * SENSITIVITY, delta * SMOOTHNESS)
	cam.rotate_y(-deg2rad(rotation_velocity.x))
	cam.rotate_x(-deg2rad(rotation_velocity.y))
	#sync y rotation to player model

	#$"../Pivot".rotation_degrees.z = rotation_tuple[1]
	
	#cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -90, 90)
	#cam.rotation_degrees.y = clamp(cam.rotation_degrees.y, -90, 90)
	camera_input = Vector2.ZERO
