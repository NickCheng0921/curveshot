extends StaticBody

#refer to grav_node.png in res://Images for basic explanation, image may be outdated
export var zone_length := 3 #sensitivity of core on when it acts on projectile
export var gravity := 5 #strength of force on bullet
onready var bullets
onready var i := 0
onready var rotate_degree := PI/6
onready var grav_node = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if i > 30:
		i = 0
	else:
		i += 1
	bullets = get_tree().get_root().get_node("Main/Bullets").get_children()
	for bullet in bullets:
		var distance = grav_node.global_transform.origin-bullet.global_transform.origin
		#is bullet close enough to be curved?
		if distance.length() < zone_length:
			#should bullet turn left or right
			if bullet.can_change_direction_y:
				#if cross product goes up, turn bullet ccw, else turn cw
				if bullet.velocity.cross(distance)[1] > 0:
					bullet.curve_y_ccw = true
				else:
					bullet.curve_y_ccw = false
				bullet.can_change_direction_y = false
			#apply curving
			if bullet.curve_y_ccw:
				bullet.velocity = bullet.velocity.rotated(Vector3(0, 1, 0), rotate_degree)
			else:
				bullet.velocity = bullet.velocity.rotated(Vector3(0, 1, 0), -rotate_degree)
