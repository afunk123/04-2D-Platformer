extends KinematicBody2D

var health = 1
var damage = 4

func _ready():
	pass

func die():
	if health <= 0:
		$AnimatedSprite.play("Dying")
		collision_layer = 0
		collision_mask = 0

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
