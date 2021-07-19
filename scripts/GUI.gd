extends CanvasLayer

signal btn_KillAllAnts_pressed

### GUI - Top_Left ############################################################
onready var GenCount_var = $MarginContainer/Top/Top_Left/Generation_Counter/Var
onready var AntsSpawned_var = $MarginContainer/Top/Top_Left/Ants_Spawned/Var
onready var AntsAlive_var = $MarginContainer/Top/Top_Left/Ants_Alive/Var
onready var AntName_var = $MarginContainer/Top/Top_Left/Ant_Name/Var
onready var AntMotivation_var = $MarginContainer/Top/Top_Left/Ant_Motivation/Var
onready var LeftDayTime_var = $MarginContainer/Top/Top_Left/Left_DayTime/Var

### GUI - Top_Right ###########################################################
onready var Btn_ToolSelection = $MarginContainer/Top/Top_Right/Btn_Tool_selection
onready var Btn_TileSelection = $MarginContainer/Top/Top_Right/Btn_Tile_selection
onready var Btn_LevelSelection = $MarginContainer/Top/Top_Right/Btn_Level_selection
onready var Btn_KillAllAnts = $MarginContainer/Top/Top_Right/Btn_KillAllAnts
onready var Btn_PauseContinue = $MarginContainer/Top/Top_Right/Btn_PauseContinue
onready var Btn_Menu = $MarginContainer/Top/Top_Right/Btn_Menu
### Other #####################################################################
var spawned_ants_max

# Called when the node enters the scene tree for the first time.
func _ready():
	addItems_Btn_Tool_Selection(Btn_ToolSelection)
	addItems_Btn_Tile_Selection(Btn_TileSelection)
	addItems_Btn_Level_Selection(Btn_LevelSelection)


func _on_Ants_Population_generation_count_label(gen_count):
	GenCount_var.text = str(gen_count)


func _on_Ants_Population_spawned_ants_label(spawned_ants):
	AntsSpawned_var.text = str(spawned_ants, " / ", spawned_ants_max)


func _on_Ants_Population_living_ants_label(living_ants):
	AntsAlive_var.text = str(living_ants)


func _on_Ant_ant_name_label(ant_name):
	AntName_var.text = ant_name


func _on_Ant_ant_motivation_label(ant_motivation):
	if ant_motivation != 0:
		AntMotivation_var.text = str(ant_motivation)
	else:
		AntMotivation_var.text = "/"


func _on_Ants_Population_left_daytime_label(left_daytime):
	LeftDayTime_var.text = str(left_daytime)


func addItems_Btn_Tool_Selection(Btn):
	Btn.add_item("Tools")
	Btn.add_separator()
	Btn.add_item("Selecting")
	Btn.add_item("Dragging")
func _on_Btn_Tool_selection_item_selected(index):
	pass # Replace with function body.


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
func _on_Btn_Tile_selection_item_selected(index):
	Global.selected_tile = index-2


func addItems_Btn_Level_Selection(Btn):
	Btn.add_item("Standard Level")
	Btn.add_separator()
	Btn.add_item("Training 1: Collision")
	Btn.add_item("Training 2: Search new Tiles")
func _on_Btn_Level_selection_item_selected(index):
	if index == 0:
		Global.goto_scene("res://scenes/Level_01_Standard.tscn")
	if index == 2:
		Global.goto_scene("res://scenes/Level_02_Training.tscn")


func _on_Btn_NextLevel_pressed():
	pass #TODO delete Button


func _on_Btn_KillAllAnts_pressed():
	emit_signal("btn_KillAllAnts_pressed")


func _on_Btn_Menu_pressed():
	Global.Menu_Button()


func _on_Btn_PauseContinue_pressed():
	if Btn_PauseContinue.text == "Pause":
		Btn_PauseContinue.text = "Continue"
		get_tree().paused = true

	else:
		Btn_PauseContinue.text = "Pause"
		get_tree().paused = false



#func _on_Ants_World_game_paused_byScript():
#	Btn_PauseContinue.text = "Continue"



