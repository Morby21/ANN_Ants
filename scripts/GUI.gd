extends MarginContainer

signal btn_KillAllAnts_pressed

### GUI - Top_Left ############################################################
onready var GenCount_var = $Top/Top_Left/Generation_Counter/Var
onready var AntsSpawned_var = $Top/Top_Left/Ants_Spawned/Var
onready var AntsAlive_var = $Top/Top_Left/Ants_Alive/Var

### GUI - Top_Right ###########################################################
onready var Btn_TileSelection = $Top/Top_Right/Btn_Tile_selection
onready var Btn_LevelSelection = $Top/Top_Right/Btn_Level_selection
onready var Btn_KillAllAnts = $Top/Top_Right/Btn_KillAllAnts
onready var Btn_PauseContinue = $Top/Top_Right/Btn_PauseContinue
onready var Btn_Menu = $Top/Top_Right/Btn_Menu
### Other #####################################################################
var spawned_ants_max

# Called when the node enters the scene tree for the first time.
func _ready():
	addItems_Btn_Tile_Selection(Btn_TileSelection)
	addItems_Btn_Level_Selection(Btn_LevelSelection)


func addItems_Btn_Tile_Selection(Btn):
	Btn.add_item("Select Tile")
	Btn.add_separator()
	Btn.add_item("NA - Lake")
	Btn.add_item("Trail")
	Btn.add_item("Gras")
	Btn.add_item("Used Gras")
	Btn.add_item("Trees")
	
#	Btn.set_item_disabled(2, true)
#	Btn.set_item_text(2, "Disabled")
func _on_Btn_Tile_selection2_item_selected(index):
	Global.selected_tile = index-2


func addItems_Btn_Level_Selection(Btn):
	Btn.add_item("Standard Level")
	Btn.add_separator()
	Btn.add_item("Training 1: Collision")
	Btn.add_item("Training 2: Search new Tiles")
func _on_Btn_Level_selection_item_selected(index):
	if index == 0:
		Global.goto_scene("res://scenes/Level_01_Standard.tscn", true, true)
	if index == 2:
		Global.goto_scene("res://scenes/Level_02_Training.tscn", true, true)


func _on_Ants_World_generation_count_label(gen_count):
	GenCount_var.text = str(gen_count)


func _on_Ants_World_living_ants_label(living_ants):
	AntsAlive_var.text = str(living_ants)


func _on_Ants_World_spawned_ants_label(spawned_ants):
	AntsSpawned_var.text = str(spawned_ants, " / ", spawned_ants_max)


func _on_Ants_World_game_paused_byScript():
	Btn_PauseContinue.text = "Continue"


func _on_Btn_NextLevel_pressed():
	pass #TODO delete Button


func _on_Btn_KillAllAnts_pressed():
	emit_signal("btn_KillAllAnts_pressed")


func _on_Btn_PauseContinue2_pressed():
	if Btn_PauseContinue.text == "Pause":
		Btn_PauseContinue.text = "Continue"
		get_tree().paused = true

	else:
		Btn_PauseContinue.text = "Pause"
		get_tree().paused = false


func _on_Btn_Menu_pressed():
	Global.Menu_Button()
