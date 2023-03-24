extends Control


func _physics_process(_delta):
	$Score.text = "Score: " + str(Global.score)
	$Lives.text = "Lives: " + str(Global.lives)
	$Health.text = "Health: 20 / " + str(Global.health)
