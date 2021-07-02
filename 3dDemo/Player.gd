extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
export var jump_impulse = 20
export var SENSITIVITY := 2
export var SMOOTHNESS := 10.0

onready var camera = $Camera
onready var Pivot = $Pivot
var camera_input : Vector2
var rotation_velocity : Vector2
var y_rotation = 0

var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		#camera input is a tuple of (x, y) movement
		camera_input = event.relative

#called every frame
var i := 1
func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	var global_y_degree = deg2rad(global_transform.basis.get_euler()[1])
	
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#$Pivot.look_at(translation + direction, Vector3.UP) 

	#mouse based rotation
	rotation_velocity = rotation_velocity.linear_interpolate(camera_input * SENSITIVITY, delta * SMOOTHNESS)
	camera.rotation_degrees.x += -deg2rad(rotation_velocity.y)
	y_rotation = -deg2rad(rotation_velocity.x)
	rotation_degrees.y += y_rotation #move mesh
	
	# Clamp vertical rotation
	rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
	camera_input = Vector2.ZERO

	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	# Moving the character
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	#print("velocity: ", velocity)
	print(velocity.x, " ", velocity.z)
	velocity.x *= -cos(global_y_degree)
	velocity.z *= sin(global_y_degree)
	print("    ", velocity.x, " ", velocity.z)
	velocity = move_and_slide(velocity, Vector3.UP)
	