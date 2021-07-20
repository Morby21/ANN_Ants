extends CanvasLayer

signal btn_KillAllAnts_pressed

### GUI - Top_Left ############################################################
onready var GenCount_var = $TopBar/Top/Top_Left/Generation_Counter/Var
onready var AntsSpawned_var = $TopBar/Top/Top_Left/Ants_Spawned/Var
onready var AntsAlive_var = $TopBar/Top/Top_Left/Ants_Alive/Var
onready var LeftDayTime_var = $TopBar/Top/Top_Left/Left_DayTime/Var

### GUI - Top_Right ###########################################################
onready var Btn_ToolSelection = $TopBar/Top/Top_Right/Btn_Tool_selection
onready var Btn_TileSelection = $TopBar/Top/Top_Right/Btn_Tile_selection
onready var Btn_LevelSelection = $TopBar/Top/Top_Right/Btn_Level_selection
onready var Btn_KillAllAnts = $TopBar/Top/Top_Right/Btn_KillAllAnts
onready var Btn_PauseContinue = $TopBar/Top/Top_Right/Btn_PauseContinue
onready var Btn_Menu = $TopBar/Top/Top_Right/Btn_Menu
### GUI - RightBottom_InfoBox #################################################
onready var AntName_var = $RightBottom_InfoBox/vBox/Ant_Name/Var
onready var AntFitness_var = $RightBottom_InfoBox/vBox/Ant_Fitness/Var
onready var AntMotivation_var = $RightBottom_InfoBox/vBox/Ant_Motivation/Var
onready var TileDetection_var = $RightBottom_InfoBox/vBox/Tile_Detection/Var
onready var CollisionDetection_var = $RightBottom_InfoBox/vBox/Collision_Detection/Var
onready var DistanceToHome_var = $RightBottom_InfoBox/vBox/Distance_to_Hive/Var
### Other #####################################################################
var spawned_ants_max

# Called when the node enters the scene tree for the first time.
func _ready():
	addItems_Btn_Tool_Selection(Btn_ToolSelection)
	addItems_Btn_Tile_Selection(Btn_TileSelection)
	addItems_Btn_Level_Selection(Btn_LevelSelection)


func _on_Ants_Population_AntIsSelected():
	$RightBottom_InfoBox.show()


func _on_Ants_Population_noAntIsSelected():
	$RightBottom_InfoBox.hide()


func _on_Ants_Population_generation_count_label(gen_count):
	GenCount_var.text = str(gen_count)


func _on_Ants_Population_spawned_ants_label(spawned_ants):
	AntsSpawned_var.text = str(spawned_ants, " / ", spawned_ants_max)


func _on_Ants_Population_living_ants_label(living_ants):
	AntsAlive_var.text = str(living_ants)


func _on_Ants_Population_left_daytime_label(left_daytime):
	LeftDayTime_var.text = str(left_daytime)


func addItems_Btn_Tool_Selection(Btn):
	Btn.add_item("Tools")
	Btn.add_separator()
	Btn.add_item("Selecting")
	Btn.add_item("Dragging")
func _on_Btn_Tool_selection_item_selected(index):
	if index == 0:
		Global.tool_is_selecting = false
		Global.tool_is_dragging = false
	elif index == 2:
		Global.tool_is_selecting = true
		Global.tool_is_dragging = false
	elif index == 3:
		Global.tool_is_dragging = true
		Global.tool_is_selecting = false


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
	Btn.add_item("Training 1: collision")
	Btn.add_item("Training 2: new tiles")
	Btn.add_item("Training 3: follow trail")
func _on_Btn_Level_selection_item_selected(index):
	if index == 0:
		Global.goto_scene("res://scenes/Level_01_Train_Tiles.tscn")
	if index == 1:
		Global.goto_scene("res://scenes/Level_02_Train_Trail.tscn")
	if index == 2:
		Global.goto_scene("res://scenes/Level_03_Train_Collision.tscn")


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


func _on_Ant_ant_name_label(ant_name):
	AntName_var.text = ant_name


func _on_Ant_ant_fitness_label(ant_fitness):
	AntFitness_var.text = str(stepify(ant_fitness, 0.1))


func _on_Ant_ant_motivation_label(ant_motivation):
	if ant_motivation != 0:
		AntMotivation_var.text = str(ant_motivation/30)
	else:
		AntMotivation_var.text = "/"


func _on_Ant_tile_detection_label(tile_detect_left, tile_detect_right):
	TileDetection_var.text = str(stepify(tile_detect_left, 0.01), "(L) / ", stepify(tile_detect_right, 0.1), "(R)")


func _on_Ant_collision_detection_label(collision_detect_left, collision_detect_right):
	CollisionDetection_var.text = str(stepify(collision_detect_left, 0.1), "(L) / ", stepify(collision_detect_right, 0.1), "(R)")


func _on_Ant_distance_to_home_label(distance):
	DistanceToHome_var.text = str(stepify(distance, 0.01))


