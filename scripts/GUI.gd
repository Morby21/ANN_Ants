extends MarginContainer

signal btn_KillAllAnts_pressed

### GUI - Top_Left ############################################################
onready var GenCount_var = $Top/Top_Left/Generation_Counter/Var
onready var AntsSpawned_var = $Top/Top_Left/Ants_Spawned/Var
onready var AntsAlive_var = $Top/Top_Left/Ants_Alive/Var

### GUI - Top_Right ###########################################################
onready var Btn_KillAllAnts = $Top/Top_Right/Btn_KillAllAnts
onready var Btn_PauseContinue = $Top/Top_Right/Btn_PauseContinue
onready var Btn_Menu = $Top/Top_Right/Btn_Menu


### Other #####################################################################
var spawned_ants_max

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#	pass


func _on_Ants_World_generation_count_label(gen_count):
	GenCount_var.text = str(gen_count)


func _on_Ants_World_living_ants_label(living_ants):
	AntsAlive_var.text = str(living_ants)


func _on_Ants_World_spawned_ants_label(spawned_ants):
	AntsSpawned_var.text = str(spawned_ants, " / ", spawned_ants_max)


func _on_Ants_World_game_paused_byScript():
	Btn_PauseContinue.text = "Continue"


func _on_Btn_NextLevel_pressed():
	Global.Next_Level()


func _on_Btn_KillAllAnts2_pressed():
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
