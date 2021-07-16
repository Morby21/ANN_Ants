extends Node

### Global variables ##########################################################

var population_size

#var MainMenu = get_tree().get_root().get_node("/root/MainMenu") 

###############################################################################
var Ant_Individium : PackedScene = preload("res://scenes/Ant_0.5.tscn")
var Ants_Population = preload("res://scenes/Ants_Population.tscn")


var Level_01_Standard = preload("res://scenes/Level_01_Standard.tscn")
var Level_02_Training = preload("res://scenes/Level_02_Training.tscn")

var Ants_Population_Instance = null
var current_scene = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var root = get_tree().get_root()
	#current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene(path, hookoff_ants_population:bool, hookup_ants_population:bool):
	## https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html
	##
	## This function will usually be called from a signal callback,
	## or some other function in the current scene.
	## Deleting the current scene at this point is
	## a bad idea, because it may still be executing code.
	## This will result in a crash or unexpected behavior.
	##
	## The solution is to defer the load to a later time, when
	## we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", path, hookoff_ants_population, hookup_ants_population)


func _deferred_goto_scene(path, hookoff_ants_population, hookup_ants_population):
	if hookoff_ants_population:
		current_scene.remove_child(Ants_Population_Instance)
	
	if current_scene != null:
		current_scene.free()
	
	## Load the new scene.
	var s = ResourceLoader.load(path)
	
	## Instance the new scene.
	current_scene = s.instance()
	
	## Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	## Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
		
	if hookup_ants_population == true:
		current_scene.add_child(Ants_Population_Instance)


func NewGame_pressed():
	Ants_Population_Instance = Ants_Population.instance()
	Ants_Population_Instance.get_child(0).size = population_size.text.to_int()
	Ants_Population_Instance.get_child(0).organism_parent_scene = Ant_Individium
	goto_scene("res://scenes/Level_01_Standard.tscn", false, true)

	#MainMenu.hide() #FIXME !!!!!


func Continue_pressed():
	if current_scene != null:
		get_tree().get_root().add_child(current_scene)
	#MainMenu.hide()


func Menu_Button():
	print("huhu")
	#MainMenu.show()
	get_tree().get_root().remove_child(current_scene)


func Exit_Game():
	get_tree().quit()


func Next_Level(): #HACK
	

	if current_scene.name == "Level_01_Standard":
		goto_scene("res://scenes/Level_02_Training.tscn", true, true)
		#current_scene = Level_02_Training.instance()
	else: 
		goto_scene("res://scenes/Level_01_Standard.tscn", true, true)
		#current_scene = Level_01_Standard.instance()
	#get_tree().get_root().add_child(current_scene)
	#current_scene.add_child(Ants_Population_Instance)


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
