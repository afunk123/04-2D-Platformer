extends KinematicBody2D

export var speed = 100
export var damage = 1
var direction = 1
var velocity = Vector2.ZERO

func _physics_process(_delta):
	velocity.x = direction * speed
	move_and_slide_with_snap(velocity, Vector2.UP)

func _on_Area2D_body_entered(body):
	if body.name == "Platform" or body.name == "Ground":
		velocity.x = 0
		direction *= -1
	if body.name == "Player":
		body.do_damage(damage)
