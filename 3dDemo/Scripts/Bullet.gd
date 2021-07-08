extends KinematicBody

var velocity := Vector3()
onready var can_change_direction_y := true #once bullet enters a grav_node's range, pick ccw or cw rotations
onready var curve_y_ccw = true #by default, from a top view, turn ccw
export var lifespan = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.set_wait_time(lifespan)
	timer.connect("timeout", self, "kill") 
	add_child(timer)
	timer.start()

func kill():
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = move_and_slide(velocity, Vector3.UP)
