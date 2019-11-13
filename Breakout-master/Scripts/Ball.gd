extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")
onready var Particles = get_node("/root/Game/Ball/Particles1")
var hits = 0;
func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Tiles"):
			Game.change_score(body.points)
			hits += 1
			body.queue_free()
			
		
	
	if position.y > get_viewport().size.y + 100:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()
		
	if hits > 1:
		Particles.amount = 2.0
		
	print(hits)