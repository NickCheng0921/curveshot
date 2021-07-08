extends StaticBody

#refer to grav_node.png in res://Images for basic explanation, image may be outdated
export var num_rings := 5 #sensitivity of core in turning
export var zone_length := 1 #sensitivity of core on when it acts on projectile
export var max_delay := 5 #time to take ring closest to core
export var min_angle := PI/16 #rotation created by outermost ring
export var max_angle := PI #rotation created by innermost ring

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
