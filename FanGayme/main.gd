extends Node2D
var menu
var office
var startButton


# Called when the node enters the scene tree for the first time.
func _ready():
	menu = load("res://menu.tscn").instantiate() #creates an instance of the menu node
	office = load("res://office.tscn").instantiate()

	startButton = menu.find_child("StartIGuess") #finds the child node named "StartIGuess" and references it
	startButton.pressed.connect(_startPressed) #triggers the _startPressed function every time the button is pressed
	add_child(menu) #adds the menu node as a child to this node, which is the main node, so that it shows up on screen


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _startPressed():
	remove_child(menu) #removes the menu node as a child to this node, making it disappear from the screen
	add_child(office)
