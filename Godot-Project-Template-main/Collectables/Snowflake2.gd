extends Area2D


export var score = 100

func _ready():
	pass


func _on_Snowflake2_body_entered(body):
	if body.name == "Player":
		Global.increase_score(score)
		queue_free()
		get_node("/root/Game/CanvasLayer/HUD/SnowflakeIcon2").show()
