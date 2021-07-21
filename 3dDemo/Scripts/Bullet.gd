extends KinematicBody

var velocity := Vector3()
export var lifespan = 3

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
	var collision_info = move_and_slide(velocity, Vector3.UP)
	if get_slide_count() > 0:
		#print(get_slide_collision(0).collider.get_name())
		queue_free()
