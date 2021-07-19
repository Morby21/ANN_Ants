extends Node

### Global variables ##########################################################
#-- General -------------------------------------------------------------------
var selected_tile: int
var tool_is_selecting: bool = false
var tool_is_dragging: bool = false

#-- Ant Population/Organism ---------------------------------------------------
var population_size

#-- MainMenu-Options (and its Standard values)---------------------------------
var Option_population_size = 20
var Option_Input_DistanceToNest = true
var Option_Input_Rotation = true
var Option_Input_Coordinations = true
var Option_Input_CollisionDetection = true
var Option_Input_TileDetection = true
var Option_Auto_HiddenLayerSizes = true
var Option_value_HiddenLayerSizes = "6,3"
var Option_lifeTimer = true
var Option_value_lifeTimer = 3000
var Option_maxLifeTimer = true
var Option_value_maxLifeTimer = 15000

###############################################################################
onready var MainMenu = get_tree().get_root().get_node("MainMenu") 

var Ant_Individium : PackedScene = preload("res://scenes/Ant_0.5.tscn")
var Ants_Population = preload("res://scenes/Ants_Population.tscn")
var Ants_Population_Instance = null
var CanvasGUI = preload("res://scenes/GUI.tscn")
var CanvasGUI_Instance = null

var current_scene = null


func _ready():
	pass
	## var root = get_tree().get_root()
	## current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene(path):
	## #https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html
	## #(Douple Hashtags shows original comments of the source-link-project)
	##
	## This function will usually be called from a signal callback,
	## or some other function in the current scene.
	## Deleting the current scene at this point is
	## a bad idea, because it may still be executing code.
	## This will result in a crash or unexpected behavior.
	##
	## The solution is to defer the load to a later time, when
	## we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# Switch scenes
	if current_scene != null:
		current_scene.free()
	## Load the new scene.
	var scene = ResourceLoader.load(path)
	## Instance the new scene.
	current_scene = scene.instance()
	## Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	## Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)


func Continue_pressed():
	if current_scene != null:
		get_tree().get_root().add_child(current_scene)
		MainMenu.queue_free()


func NewGame_pressed():
	CanvasGUI_Instance = CanvasGUI.instance()
	Ants_Population_Instance = Ants_Population.instance()
	Ants_Population_Instance.get_child(0).size = Option_population_size
	#TODO Hiddenlayers
	Ants_Population_Instance.get_child(0).organism_parent_scene = Ant_Individium
	goto_scene("res://scenes/Level_01_Standard.tscn")
	MainMenu.queue_free()


func Exit_Game():
	get_tree().quit()


func Menu_Button():
	var MainMenu_load = ResourceLoader.load("res://scenes/MainMenu.tscn") #TODO preload on
	MainMenu = MainMenu_load.instance() #MainMenu.show()
	get_tree().get_root().add_child(MainMenu)
	get_tree().get_root().remove_child(current_scene)


### Private variables #########################################################
#https://godotengine.org/qa/7983/private-vars-inside-custom-godot-script-class
#var my_good_private_x = 6 setget private_gs,private_gs
#var my_better_private_y = 9 setget private_gs,private_gs
#
#func private_gs(val = null): 
#    # Using a default value to make it possible to call with both 1 and 0 arguments (e.g. both as setter and getter)
#    print("Access to private variable!!!")
#    print_stack()
#    pass # No set, no get for you!
#
## Usage:
#func _ready():
#    my_good_private_x = 54 # works!
#    print(my_good_private_x) # 54
#    self.my_better_private_y = 23 # migth work, depends on which version of godot you use
#
###############################################################################

#https://docs.godotengine.org/de/stable/tutorials/inputs/input_examples.html
#
#var dragging = false
#var click_radius = 32 # Size of the sprite.
#
#func _input(event):
#    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
#        if (event.position - $Sprite.position).length() < click_radius:
#            # Start dragging if the click is on the sprite.
#            if not dragging and event.pressed:
#                dragging = true
#        # Stop dragging if the button is released.
#        if dragging and not event.pressed:
#            dragging = false
#
#    if event is InputEventMouseMotion and dragging:
#        # While dragging, move the sprite with the mouse.
#        $Sprite.position = event.position
