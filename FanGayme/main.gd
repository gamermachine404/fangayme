extends Node2D
var menu
var office
var startButton
var continueButton
var Nightclock
var night = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#add_child(menu) #adds the menu node as a child to this node, which is the main node, so that it shows up on screen
	#remove_child(menu) #removes the menu node as a child to this node, making it disappear from the screen
	#menu = load("res://menu.tscn").instantiate() #creates an instance of the menu node
	#office = load("res://office.tscn").instantiate() 
	# (this is here so we dont forget that we can do that)

	menu = $Menu
	office = $Office 

	Nightclock =$Clock

	startButton = menu.find_child("StartIGuess") #finds the child node named "StartIGuess" and references it
	startButton.pressed.connect(startPressed) #triggers the _startPressed function every time the button is pressed
	continueButton = menu.find_child("StartIGuess2")
	continueButton.pressed.connect(startNight)

	office.visible = false

	updateNight()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func startNight():
	menu.visible = false
	office.visible = true
	Nightclock.startNight()
	office.startNight()

func updateNight():
	continueButton.text = "Old game- " + str(night)

func startPressed():
	night = 1
	startNight()

func endNight():
	pass
