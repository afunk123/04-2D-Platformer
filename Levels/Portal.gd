extends Area2D


func _ready():
	pass


func _on_Portal_body_entered(body):
	if body.name == "Player":
		if name == "Portal_to_2":
			Global.level = 2
			var _scene = get_tree().change_scene("res://Levels/Level2.tscn")
		if name == "Portal_to_3":
			var _scene = get_tree().change_scene("res://Levels/Level3.tscn")
			Global.level = 3
		if name == "Portal_to_win":
			var _scene = get_tree().change_scene("res://Levels/Game_Over.tscn")
