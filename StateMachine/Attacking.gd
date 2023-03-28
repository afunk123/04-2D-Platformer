extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Attacking", Vector2(15,0))

func physics_process(_delta):
	if player.is_on_ceiling():
		player.velocity.y = 0
	if not player.is_on_floor():
		player.velocity += player.move_speed * player.move_vector() + player.gravity
		player.move_and_slide(player.velocity, Vector2.UP)
	if Input.is_action_pressed("attack"):
		player.attack()
	elif player.is_moving():
		SM.set_state("Moving")
	else:
		SM.set_state("Idle")
