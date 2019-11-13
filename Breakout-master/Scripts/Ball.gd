extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")
onready var Particles = get_node("/root/Game/Ball/Particles1")
onready var Paddle = get_node("/root/Game/Paddle")
var hits = 0;
func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	var animation = Paddle.get_node("AnimationPlayer")
	for body in bodies:
		if body.is_in_group("Tiles"):
			Game.change_score(body.points)
			hits += 1
			body.queue_free()
		if body == Paddle:
			if hits > 2:
				animation.play("ChargeHit")	
			hits = 0
		
	
	if position.y > get_viewport().size.y + 100:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()
		
	if hits < 3:
		Particles.process_material.scale_random = 0.0
	if hits > 2:
		Particles.amount = 2.0
		Particles.process_material.scale_random = 0.5		
	elif hits > 4:
		Particles.amount = 3.0
		Particles.process_material.scale_random = 1.0	
	
	print(hits)