extends KinematicBody2D

onready var SM = $StateMachine
onready var Attack = load("res://Player/Attack.tscn")
onready var camera = get_node("/root/Game/Camera")
onready var overlay = get_node("/root/Game/CanvasLayer/Overlay")
onready var overlay_die = get_node("/root/Game/CanvasLayer/Overlay_Die")

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1

export var gravity = Vector2(0,30)

export var move_speed = 20
export var max_move = 300

export var jump_speed = 200
export var max_jump = 400

export var leap_speed = 200

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite

var paused = false

func _ready():
	overlay_die.connect("faded_out", self, "_faded_out")
	overlay_die.connect("faded_in", self, "_faded_in")
	paused = true
	overlay_die.fade_in()

func _physics_process(_delta):
	if not paused:
		velocity.x = clamp(velocity.x,-max_move,max_move)
			
		if should_direction_flip:
			if direction < 0 and not $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = true
			if direction > 0 and $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = false
		
		if Input.is_action_pressed("attack"):
			SM.set_state("Attacking")
		
		if is_on_floor():
			double_jumped = false
			set_wall_raycasts(true)
		
		
func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim, off = Vector2.ZERO):
	off.x *= direction
	$AnimatedSprite.offset = off
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false

func is_on_right_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func is_on_left_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func get_right_collider():
	return $Wall/Right.get_collider()

func get_left_collider():
	return $Wall/Left.get_collider()
	
func set_wall_raycasts(is_enabled):
	$Wall/Left.enabled = is_enabled
	$Wall/Right.enabled = is_enabled

func attack():
	var enemies = $Attacking.get_overlapping_bodies()
	for enemy in enemies:
		if enemy.has_method("die"):
			enemy.die()


func do_damage(d):
	camera.add_trauma(0.7)
	overlay.add_trauma(0.4)
	Global.decrease_health(d)
	if Global.health <= 0:
		die()

func _on_AnimatedSprite_animation_finished():
	if Global.health <= 0:
		$AnimatedSprite.play("Dying")
		die()

func die():
	Global.decrease_lives(1)
	overlay_die.fade_out()
	queue_free()

func _faded_out():
	queue_free()

func _faded_in():
	paused = false


