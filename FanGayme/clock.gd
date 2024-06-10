extends Label
var elapsedTime = 0
var parent


# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func startNight():
	elapsedTime = 0
	visible = true
	text = "12 AM"

	for n in 8:
		await get_tree().create_timer(1.0).timeout
		print("hour passed")
		elapsedTime += 1
		text = str(elapsedTime) + " AM"
		if elapsedTime == 8:
			print("night over")
