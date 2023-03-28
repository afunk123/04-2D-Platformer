extends Area2D

var direction = 1
var damage = 1
var dead = false

func ready():
	$AnimatedSprite.animation = "Start"
	$AnimatedSprite.playing = true

func _physics_process(_delta):
	if direction < 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if direction > 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false

func _on_Attack_body_entered(body):
	if not dead:
		if body.name == "Player":
			pass
		if body.get_parent().name == "Enemy_Container":
			body.do_damage()
		$AnimatedSprite.animation = "After"
		dead = true

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Start":
		$AnimatedSprite.animation = "Attacking"
	if $AnimatedSprite.animation == "After":
		queue_free()
	$AnimatedSprite.playing = true
