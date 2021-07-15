extends Node

var Ants_World = preload("res://scenes/Ants_World.tscn")
var Ants_World_Instance
var Ants_World_Instance_existing = false

var Input_Count


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass 

func _on_MainMenu_MainMenu_Continue_pressed():
	if Ants_World_Instance_existing:
		add_child(Ants_World_Instance)
	#print($MainMenu.hidden_layers.text.to_int())
	#print($MainMenu/HBoxContainer/CenterContainer_Options/VBoxContainer/HBoxContainer/LineEdit_Population_Size.text.to_int())
	
func _on_MainMenu_MainMenu_NewGame_pressed():
	Ants_World_Instance = Ants_World.instance()
	var population = Ants_World_Instance.get_node("Population")
	#population.size = $MainMenu/HBoxContainer/CenterContainer_Options/VBoxContainer/HBoxContainer/LineEdit_Population_Size.text.to_int()
	population.size = $MainMenu.Option_population_size.text.to_int()
	
	#var ant = Ants_World_Instance.get_node("Population").get
	add_child(Ants_World_Instance)


func on_Menu_Button():
	#Ants_World_Instance.queue_free()
	remove_child(Ants_World_Instance)
	Ants_World_Instance_existing = true

