extends Node2D

onready var Fireball = load("res://Enemies/Fireball.tscn")
onready var Pheonix = load("res://Enemies/Pheonix.tscn")
onready var Spider = load("res://Enemies/Spider.tscn")

func spawn(e_type, attr, p):
	var enemy = null
	if e_type == "Fireball":
		enemy = Fireball.instance()
	if e_type == "Pheonix":
		enemy = Pheonix.instance()
	if e_type == "Spider":
		enemy = Spider.instance()
	for a in attr:
		enemy[a] = attr[a]
		enemy.position = p
		add_child(enemy)
