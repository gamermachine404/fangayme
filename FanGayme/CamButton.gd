extends Button

var office

# Called when the node enters the scene tree for the first time.
func _ready():
	office = get_parent().get_parent().get_parent() #plap plap plap


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	var camNum = int(0)
	camNum = (str(text).unicode_at(0) - 48) * 10
	camNum += str(text).unicode_at(2) - 48
	office.changeCameras(camNum)

