extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.mouse_entered.connect(_flip)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _flip():
	print("flip")
