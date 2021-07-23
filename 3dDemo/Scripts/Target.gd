extends KinematicBody

var taco_wait_time = 2.0 #seconds between hit sounds and color change
var can_play_sound = true
var taco_timer = null
var color_red = SpatialMaterial.new()
var color_green = SpatialMaterial.new()
var velocity = Vector3(7, 0, 0)

var y_axis := Vector3(0, 1, 0)
var x_axis := Vector3(1, 0, 0)
var z_axis := Vector3(0, 0, 1)
var i := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	taco_timer = Timer.new()
	taco_timer.set_one_shot(true)
	taco_timer.set_wait_time(taco_wait_time)
	taco_timer.connect("timeout", self, "taco_time_over")
	add_child(taco_timer)
	
	#setup colors
	color_red.albedo_color = Color(255, 0, 0, 255)
	color_green.albedo_color = Color(0, 255, 0, 255)

func taco_bell():
	if can_play_sound:
		can_play_sound = false
		#play sound
		$AudioStreamPlayer.play()
		#change color
		$MeshInstance.set_material_override(color_green)
		#start timer
		taco_timer.start()
		
func taco_time_over():
	can_play_sound = true
	$MeshInstance.set_material_override(color_red)
	
func _process(delta):
	if i >= 60:
		velocity = velocity.rotated(x_axis, randi())
		velocity = velocity.rotated(y_axis, randi())
		velocity = velocity.rotated(z_axis, randi())
		i = 0
	i += 1
	move_and_slide(velocity, Vector3.UP)
