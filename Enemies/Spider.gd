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
	player = get_node("/root/Game/Player_Container/Player")
	if player != null:
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		if c:
			velocity = ray.cast_to.normalized() * looking_speed
			if c.name == "Player":
				velocity = ray.cast_to.normalized() * speed
				velocity = move_and_slide(velocity, Vector2(0,0))
		$AnimatedSprite.play("Moving")

func _on_Area2D_body_entered(body):
	if body.name == "Player" and health > 0:
		$AnimatedSprite.play("Attacking")
		body.do_damage(damage)
	if body.name == null:
		$AnimatedSprite.play("Moving")
		
func die():
	health -= 1
	if health <= 0:
		$AnimatedSprite.play("Dying")
		collision_layer = 0
		collision_mask = 0

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
