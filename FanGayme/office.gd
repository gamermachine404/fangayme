extends Node2D
var barArea
var monitorSprite
var cameraOpen
var animatronic1Position
var cameras
var flipping

# Called when the node enters the scene tree for the first time.
func _ready():
	barArea = $BarArea
	monitorSprite = $MonitorSprite
	cameras = $Cameras
	cameraOpen = false
	cameras.visible = false
	flipping = false
	

	barArea.mouse_entered.connect(_flip)
	barArea.mouse_exited.connect(_activateBar)
	monitorSprite.visible = false
	monitorSprite.animation_finished.connect(_flipEnd)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func nightStart():
	#activates at the start of the night
	for n in 8:
		#wait function
		processAnimatronic1Movement()
	
func _flip():
	#activates when the mouse goes on the bar (when the cameras are toggled)
	if !flipping:
		print("flip")
		$Bar.visible = false
		flipping = true
		monitorSprite.visible = true
		monitorSprite.animation = "default"

		if cameraOpen:
			monitorSprite.play_backwards()
			cameras.visible = false
		else: 
			monitorSprite.play()

	
	
func _flipEnd():
	#activates after the flip animation is done
	monitorSprite.visible = false
	flipping = false
	cameraOpen = !cameraOpen
	
	if cameraOpen:
		cameras.visible = true

func _activateBar():
	#activates after the mouse comes off the bar
	$Bar.visible = true

func processAnimatronic1Movement():
	#process stuff
	pass

