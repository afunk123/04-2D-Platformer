extends KinematicBody2D

export var speed = 100
export var damage = 4
export var max_constraints = 100
export var min_constraints = -100
var direction = 1
var velocity = Vector2.ZERO

var health = 1

func _physics_process(_delta):
	if direction < 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if direction > 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	if direction > 0 and position.x >= max_constraints:
		direction = -1
	if direction < 0 and position.x <= min_constraints:
		direction = 1
	
	velocity.x = direction * speed
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_body_entered(body):
	if velocity.x != 0 and (body.name == "Platform" or body.name == "Ground"):
		velocity.x = 0
		direction *= -1
	if body.name == "Player" and health > 0:
		body.do_damage(damage)

func die():
	health -= 1
	if health <= 0:
		$AnimatedSprite.play("Dying")
		$AnimatedSprite.offset = Vector2(-1, -8)
		collision_layer = 0
		velocity.x = 0
		collision_mask = 0

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
