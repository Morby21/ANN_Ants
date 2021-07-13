extends MarginContainer

signal btn_KillAllAnts_pressed
signal btn_Pause_pressed
signal btn_Continue_pressed
signal btn_Menu_pressed

### GUI - Top_Left ############################################################
onready var GenCount_label = $Top/Top_Left/Generation_Counter/Label
onready var GenCount_var = $Top/Top_Left/Generation_Counter/Var
onready var AntsSpawned_label = $Top/Top_Left/Ants_Spawned/Label
onready var AntsSpawned_var = $Top/Top_Left/Ants_Spawned/Var
onready var AntsAlive_label = $Top/Top_Left/Ants_Alive/Label
onready var AntsAlive_var = $Top/Top_Left/Ants_Alive/Var

### GUI - Top_Right ###########################################################
onready var Btn_KillAllAnts = $Top/Top_Right/Btn_KillAllAnts
onready var Btn_PauseContinue = $Top/Top_Right/Btn_PauseContinue
onready var Btn_Menu = $Top/Top_Right/Btn_Menu


### Other #####################################################################
var spawned_ants_max

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(get_parent().get_parent().get_parent())
	$Top/Top_Right/Btn_Menu.connect("pressed", get_parent().get_parent().get_parent(), "on_Menu_Button")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#	pass


func _on_Btn_KillAllAnts2_pressed():
	emit_signal("btn_KillAllAnts_pressed")


func _on_Ants_World_generation_count_label(gen_count):
	GenCount_var.text = str(gen_count)


func _on_Ants_World_living_ants_label(living_ants):
	AntsAlive_var.text = str(living_ants)


func _on_Ants_World_spawned_ants_label(spawned_ants):
	AntsSpawned_var.text = str(spawned_ants, " / ", spawned_ants_max)


func _on_Btn_PauseContinue2_pressed():
	if Btn_PauseContinue.text == "Pause":
		Btn_PauseContinue.text = "Continue"
		emit_signal("btn_Pause_pressed")
	else:
		Btn_PauseContinue.text = "Pause"
		emit_signal("btn_Continue_pressed")


func _on_Ants_World_game_paused_byScript():
	Btn_PauseContinue.text = "Continue"

