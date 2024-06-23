extends Node2D
var random = RandomNumberGenerator.new()

var barArea
var monitorSprite
var cameraOpen
var animatronic1Position
var cameras
var flipping
var currentCamera
var a1Pos

var cameraTimers = [] #Initialize the camera timer array. This will be an array of array of ints.
#It will look something like this: [[0,0],[1,1,1]]

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
	
	setupCameras()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func startNight():
	#activates at the start of the night
	randomizeCamTimers()
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

func changeCameras(number):
	# A-make sure to make it play the shortened blur animation whenever this is called
	currentCamera = number
	updateCameras()

func updateCameras():
	#make it so this function uses the 1 and 2 digit of camera names via unicode to detect
	#which camera it should switch to
	#var digit2 = str(currentCamera).unicode_at(1) to check with unicode
	for image in cameras.find_child("RoomImages").get_children():
		image.visible = false
		if int(str(image.name)) == currentCamera:
			image.visible = true 



#A-make a separate function here which changes the visual effect of a camera to a blur
#for a set amount of time whenver an animatronic position changes to or from the value of that camera
func processAnimatronic1Movement():
	#process stuff
	pass
	
func setupCameras():
	#This is code that will allow us to automatically make an array that contains an array of ints (the timers)
	#for each camera sector, and make it so the text of the camera buttons matches their names without us having
	#to do anything.
	#It requires us to name the camera button properly, like so:
	#Cam[sector #]_[camera #]. For example, the third camera of the fourth sector would be "Cam4_1".
	
	var currentCheckUnicode = -1 #set the current unicode check offset to -1, so it will add an array to the array
	
	#The following code uses the unicode values of characters to determine which
	#number is in the fourth position of the button's name. In unicode, 1 is 49, 2 is 50, etc.
	
	for kc in cameras.find_child("CamButtons").get_children():
		if currentCheckUnicode + 49 != kc.name.unicode_at(3): #Checks unicode at 4th position in name
			currentCheckUnicode += 1
			cameraTimers = cameraTimers + [[]] #[] -> [[]] -> [[],[]] 
			#Since we can't reference an array with an entry that doesn't exist, we need to make a new one.
			#The code up there merges an array with the array, so [[0,0]] + [[]] will make [[0,0],[]], for example.
		cameraTimers[currentCheckUnicode] = cameraTimers[currentCheckUnicode] + [currentCheckUnicode]
		kc.text = str(kc.name.unicode_at(3)-48) + "_" + str(kc.name.unicode_at(5)-48)
	print(cameraTimers)

#cameraTimers[0]: gives you 1st element cameraTimers[1]: gives you second
	
func randomizeCamTimers():
	var averages = []
	var current1 = 0
	var current2 = 0
	for camGroup in cameraTimers:
		current2 = 0 
		averages = averages + [0]
		for n in camGroup.size():
			cameraTimers[current1][n] = random.randi_range(40,120)
			averages[current1] += cameraTimers[current1][n]
			current2 += 1 #equal to the number of times the loop was repeated
		averages[current1] = averages[current1] / current2
		current1 +=1 #equal to the number of times the loop was repeated
	print("averages: " + str(averages))
	print("camera timers: " + str(cameraTimers))
	var averagesSorted = averages.duplicate()
	averagesSorted.sort()
	current1 = 0
	current2 = 0
	for avg in averages:
		if true:
			current2 = (averagesSorted.find(avg) * 20)
			print(current2)
			for n in cameraTimers[current1].size():
				cameraTimers[current1][n] = cameraTimers[current1][n] + current2
		current1 += 1 #equal to the amount of times this loop was repeated
	print("after balancing: ")
	debug_getCamTimersAndAvg()
	
func debug_getCamTimersAndAvg():
	print("camera timers: " + str(cameraTimers))
	var averages = []
	var current1 = 0
	var current2 = 0
	for camGroup in cameraTimers:
		current2 = 0 
		averages = averages + [0]
		for n in camGroup.size():
			averages[current1] += cameraTimers[current1][n]
			current2 += 1 #equal to the number of times the loop was repeated
		averages[current1] = averages[current1] / current2
		current1 +=1 #equal to the number of times the loop was repeated
	print("averages: " + str(averages))

