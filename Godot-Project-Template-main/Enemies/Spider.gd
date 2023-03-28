extends KinematicBody2D

var health = 1
var player = null
export var damage = 4
onready var ray = $RayCast2D
export var speed = 150
export var looking_speed = 100
var velocity = Vector2.ZERO


func _ready():
	pass

func _physics_process(_delta):
	if player == null:
		player = get_node_or_null("/root/Game/Player_Container/Player")
	else:
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		if c:
			velocity = ray.cast_to.normalized() * looking_speed
			if c.name == "Player":
				velocity = ray.cast_to.normalized() * speed
				move_and_slide(velocity, Vector2(0,0))
		$AnimatedSprite.play("Moving")

func _on_Sight_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite.play("Attacking")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.do_damage(damage)

func die():
	if health <= 0:
		$AnimatedSprite.play("Dying")
		collision_layer = 0
		collision_mask = 0

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
