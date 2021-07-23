extends StaticBody

#refer to grav_node.png in res://Images for basic explanation, image may be outdated
export var zone_length := 2 #sensitivity of core on when it acts on projectile
export var gravity := 10 #strength of force on bullet
onready var bullets
onready var i := 0
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
			bullet.primed = true
			distance = distance.normalized()
			distance *= gravity
			bullet.velocity += distance
