extends Node

#var Ants_World = preload("res://scenes/Ants_World.tscn")
#var Ants_World_Instance
#var Ants_World_Instance_existing = false
#
#var Ants_Population = preload("res://scenes/Ants_Population.tscn")
##var Ants_Population = preload("res://neft_godot/scenes/Population.tscn")
#var Ants_Population_Instance
#var Ants_Population_Instance_existing = false
#
#var Ant_Idividium : PackedScene = preload("res://scenes/Ant_0.5.tscn")
#
#var Input_Count


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass 

func _on_MainMenu_MainMenu_Continue_pressed():
#	if Ants_World_Instance_existing:
#		add_child(Ants_World_Instance)
#	#print($MainMenu.hidden_layers.text.to_int())
#	#print($MainMenu/HBoxContainer/CenterContainer_Options/VBoxContainer/HBoxContainer/LineEdit_Population_Size.text.to_int())
	Global.Continue_pressed()
	
func _on_MainMenu_MainMenu_NewGame_pressed():
#	Ants_Population_Instance = Ants_Population.instance()
#	Ants_Population_Instance.get_child(0).size = $MainMenu.Option_population_size.text.to_int()
#	Ants_Population_Instance.get_child(0).organism_parent_scene = Ant_Idividium
#
#	Ants_World_Instance = Ants_World.instance()
#	#get_tree().get_root().add_child(Ants_World_Instance)
#	add_child(Ants_World_Instance)
#
#	Ants_World_Instance.add_child(Ants_Population_Instance)
	
	Global.NewGame_pressed()
	


func on_Menu_Button():
#	#Ants_World_Instance.queue_free()
#	remove_child(Ants_World_Instance)
#	Ants_World_Instance_existing = true
	Global.Menu_Button()
