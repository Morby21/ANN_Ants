extends Node

### Global variables ##########################################################

var spawned_ants : int setget spawned_ants_set #The number of spawned ants, for GUI

###############################################################################

var Ants_World = preload("res://scenes/Ants_World.tscn")
var Ants_World_Instance
var Ants_World_Instance_existing = false

var Ants_Population = preload("res://scenes/Ants_Population.tscn")
#var Ants_Population = preload("res://neft_godot/scenes/Population.tscn")
var Ants_Population_Instance
var Ants_Population_Instance_existing = false

var Ant_Idividium : PackedScene = preload("res://scenes/Ant_0.5.tscn")

var Input_Count


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass 

func spawned_ants_set(new_val):
	spawned_ants = new_val
	get_tree().get_root().get_node("Ants_World").get_node("CanvasLayer").get_node("GUI")._on_Ants_World_living_ants_label(new_val)

func Continue_pressed():
	if Ants_World_Instance_existing:
		get_tree().get_root().add_child(Ants_World_Instance)
	#print($MainMenu.hidden_layers.text.to_int())
	#print($MainMenu/HBoxContainer/CenterContainer_Options/VBoxContainer/HBoxContainer/LineEdit_Population_Size.text.to_int())


func NewGame_pressed():
	Ants_Population_Instance = Ants_Population.instance()
	Ants_Population_Instance.get_child(0).size = 10 #$MainMenu.Option_population_size.text.to_int()
	Ants_Population_Instance.get_child(0).organism_parent_scene = Ant_Idividium
	
	Ants_World_Instance = Ants_World.instance()
	get_tree().get_root().add_child(Ants_World_Instance)
	#get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1).add_child(Ants_World_Instance)
	#add_child(Ants_World_Instance)
	
	Ants_World_Instance.add_child(Ants_Population_Instance)


func Menu_Button():
	#Ants_World_Instance.queue_free()
	get_tree().get_root().remove_child(Ants_World_Instance)
	Ants_World_Instance_existing = true

