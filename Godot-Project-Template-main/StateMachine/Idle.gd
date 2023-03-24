extends Node

onready var SM = get_parent()
onready var player = get_node("../..")


func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Idle")
	player.jump_power = Vector2.ZERO

func _physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if player.is_on_floor():
		SM.set_state("Moving")
	if Input.is_action_pressed("jump"):
		SM.set_state("Jumping")
