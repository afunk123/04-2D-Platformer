extends ColorRect

var increase = 0
signal faded_in
signal faded_out

func _ready():
	pass

func _physics_process(_delta):
	if increase:
		color.a = clamp(color.a + increase, 0, 1)
		if color.a == 1:
			increase = 0
			emit_signal("faded_out")
		if color.a == 0:
			increase = 0
			emit_signal("faded_in")

func fade_out():
	increase = 0.05
	color.a = 0.001

func fade_in():
	increase = -0.05
	color.a = 0.999
