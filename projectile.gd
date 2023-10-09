extends CharacterBody2D

@export var target : CharacterBody2D
@export var speed = 800
@export var acceleration = 3000
@export var damage = 10

var target_position
var direction

func _ready():
	target_position = target.global_position
	direction = global_position.direction_to(target_position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	move_and_slide()

func _on_hit_detection_body_entered(body):
	if body == target:
		body.deal_damage(damage)
		queue_free()

func _on_timer_timeout():
	queue_free()
