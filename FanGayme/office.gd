extends Node2D
var barArea
var monitorSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	barArea = $BarArea
	monitorSprite = $MonitorSprite
	
	barArea.mouse_entered.connect(_flip)
	barArea.mouse_exited.connect(_activateBar)
	monitorSprite.visible = false
	monitorSprite.animation_finished.connect(_flipEnd)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _flip():
	print("flip")
	$Bar.visible = false
	monitorSprite.visible = true
	monitorSprite.animation = "default"
	monitorSprite.play()
	
func _flipEnd():
	monitorSprite.visible = false
	
func _activateBar():
	$Bar.visible = true
