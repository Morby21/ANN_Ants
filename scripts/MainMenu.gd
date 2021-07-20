extends MarginContainer

var mouseOn_Continue = false
var mouseOn_NewGame = false
var mouseOn_Options = false
var mouseOn_Exit = false
var is_options = false

### Menu - Backbone ###########################################################
onready var Btn_Continue = $HBoxContainer/VBoxContainer/MenuOptions/Continue
onready var options_container = $HBoxContainer/CenterContainer_Options
onready var noOptions_container = $HBoxContainer/CenterContainer_noOptions
onready var Version_label = $HBoxContainer/VBoxContainer/Version/Label

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
	#Initialise Option Settings
	Option_population_size.text = str(Global.Option_population_size)
	Option_Input_DistanceToNest.pressed = Global.Option_Input_DistanceToNest
	Option_Input_Rotation.pressed = Global.Option_Input_Rotation
	Option_Input_Coordinations.pressed = Global.Option_Input_Coordinations
	Option_Input_CollisionDetection.pressed = Global.Option_Input_CollisionDetection
	Option_Input_TileDetection.pressed = Global.Option_Input_TileDetection
	Option_Auto_HiddenLayerSizes.pressed = Global.Option_Auto_HiddenLayerSizes
	Option_value_HiddenLayerSizes.text = Global.Option_value_HiddenLayerSizes
	Option_lifeTimer.pressed = Global.Option_lifeTimer
	Option_value_lifeTimer.text = str(Global.Option_value_lifeTimer)
	Option_maxLifeTimer.pressed = Global.Option_maxLifeTimer
	Option_value_maxLifeTimer.text = str(Global.Option_value_maxLifeTimer)
	
	#Continue-Button show/hide
	if Global.current_scene != null:
		Btn_Continue.show()
	
	#Setup the Version number
	Version_label.text = str("Version ", Global.version_number)


func saveOptions_on_NewGameBtn():
	Global.Option_population_size = Option_population_size.text.to_int()
	Global.Option_Input_DistanceToNest = Option_Input_DistanceToNest.pressed
	Global.Option_Input_Rotation = Option_Input_Rotation.pressed
	Global.Option_Input_Coordinations = Option_Input_Coordinations.pressed
	Global.Option_Input_CollisionDetection = Option_Input_CollisionDetection.pressed
	Global.Option_Input_TileDetection = Option_Input_TileDetection.pressed
	Global.Option_Auto_HiddenLayerSizes = Option_Auto_HiddenLayerSizes.pressed
	Global.Option_value_HiddenLayerSizes = Option_value_HiddenLayerSizes.text
	Global.Option_lifeTimer = Option_lifeTimer.pressed
	Global.Option_value_lifeTimer = Option_value_lifeTimer.text.to_int()
	Global.Option_maxLifeTimer = Option_maxLifeTimer.pressed
	Global.Option_value_maxLifeTimer = Option_value_maxLifeTimer.text.to_int()


func _input(event):
#	if event is InputEventScreenTouch: #TODO TouchScreen-Support integrieren
#		if event.is_pressed():
	if is_visible():
		if event.is_action_pressed("MouseClick_Left"):
			if mouseOn_Continue == true:
				#emit_signal("MainMenu_Continue_pressed")
				Global.Continue_pressed()
			if mouseOn_NewGame == true:
				#emit_signal("MainMenu_NewGame_pressed")
				#Global.population_size = Option_population_size # nicht benötigt wenn stat Backbone Globals im ready gesetzt werden
				saveOptions_on_NewGameBtn()
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
			if mouseOn_Exit == true:
				Global.Exit_Game()


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


func _on_Exit_mouse_entered():
	mouseOn_Exit = true
func _on_Exit_mouse_exited():
	mouseOn_Exit = false



