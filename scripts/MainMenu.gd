extends MarginContainer

#signal MainMenu_Continue_pressed
#signal MainMenu_NewGame_pressed

var mouseOn_Continue = false
var mouseOn_NewGame = false
var mouseOn_Options = false
var mouse_Exit = false

var is_options
#test
### Menu - Backbone ###########################################################
onready var options_container = $HBoxContainer/CenterContainer_Options
onready var noOptions_container = $HBoxContainer/CenterContainer_noOptions

### Options - Backbone ########################################################
onready var Option_population_size = $HBoxContainer/CenterContainer_Options/Option_List/Option_population_size/LineEdit
onready var Option_Input_DistanceToNest  = $HBoxContainer/CenterContainer_Options/Option_List/Option_Input_DistanceToNest/CheckButton
onready var Option_Input_Rotation = $HBoxContainer/CenterContainer_Options/Option_List/Option_Input_Rotation/CheckButton
onready var Option_Input_Coordinations = $HBoxContainer/CenterContainer_Options/Option_List/Option_Input_Coordinations/CheckButton
onready var Option_Input_CollisionDetection = $HBoxContainer/CenterContainer_Options/Option_List/Option_Input_CollisionDetection/CheckButton
onready var Option_Input_TileDetection = $HBoxContainer/CenterContainer_Options/Option_List/Option_Input_TileDetection/CheckButton
onready var Option_Auto_HiddenLayerSizes = $HBoxContainer/CenterContainer_Options/Option_List/Option_Auto_HiddenLayerSizes/CheckButton
onready var Option_value_HiddenLayerSizes = $HBoxContainer/CenterContainer_Options/Option_List/Option_value_HiddenLayerSizes/LineEdit
onready var Option_lifeTimer = $HBoxContainer/CenterContainer_Options/Option_List/Option_lifeTimer/CheckButton
onready var Option_value_lifeTimer = $HBoxContainer/CenterContainer_Options/Option_List/Option_value_lifeTimer/LineEdit
onready var Option_maxLifeTimer = $HBoxContainer/CenterContainer_Options/Option_List/Option_maxLifeTimer/CheckButton
onready var Option_value_maxLifeTimer = $HBoxContainer/CenterContainer_Options/Option_List/Option_value_maxLifeTimer/LineEdit

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
#	if event is InputEventScreenTouch: #TODO TS-Support integrieren
#		if event.is_pressed():
	if event.is_action_pressed("MouseClick_Left"):
		if mouseOn_Continue == true:
			#emit_signal("MainMenu_Continue_pressed")
			Global.Continue_pressed()
		if mouseOn_NewGame == true:
			#emit_signal("MainMenu_NewGame_pressed")
			Global.population_size = Option_population_size
			Global.NewGame_pressed()
		if mouseOn_Options == true:
			if is_options:
				options_container.hide()
				noOptions_container.show()
				is_options = false
			else:
				noOptions_container.hide()
				options_container.show()
				is_options = true


func _on_Continue_mouse_entered():
	mouseOn_Continue = true
func _on_Continue_mouse_exited():
	mouseOn_Continue = false


func _on_NewGame_mouse_entered():
	mouseOn_NewGame = true
func _on_NewGame_mouse_exited():
	mouseOn_NewGame = false


func _on_Options_mouse_entered():
	mouseOn_Options = true
func _on_Options_mouse_exited():
	mouseOn_Options = false


func _on_Exit_pressed():
	Global.Exit_Game()
