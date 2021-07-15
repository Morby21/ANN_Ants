extends Node

signal last_ants
signal new_generation
signal generation_count_label(gen_count)
signal living_ants_label(a)
signal spawned_ants_label(a)
signal game_paused_byScript()

var everybody_ready = false
var spawn_timer : int
#var ant_count = false
var spawned_ants
var living_ants
var living_ants_old
var gen_count = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	var GUI = get_parent().get_node("CanvasLayer").get_node("GUI")
	connect("generation_count_label", GUI, "_on_Ants_World_generation_count_label")
	connect("living_ants_label", GUI, "_on_Ants_World_living_ants_label")
	connect("spawned_ants_label", GUI, "_on_Ants_World_spawned_ants_label")
	connect("_on_GUI_btn_KillAllAnts_pressed", GUI, "btn_KillAllAnts_pressed") #FIXME evtl geht es nicht weil "falsche Richtung"
	GUI.spawned_ants_max = $Population.size
	#spawn_timer = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	everybody_ready = true
	for child in $Population.get_children():
		if !child.get_is_ready():
			# at least one child is not ready
			everybody_ready = false
			break
	
	print_population_status() # !Call before var everybody_ready is resetted
	
	if everybody_ready:
		emit_signal("new_generation")#TODO wo ging das Signal mal hin?
		$Population.next_generation()
		gen_count = gen_count + 1
		emit_signal("generation_count_label", gen_count)
		spawn_timer = 0
		for ant in $Population.get_children():
			ant.reset()
			#ant.respawn(spawn_timer)
			ant.trigger_respawn(spawn_timer)
#			ant_count = false
			spawn_timer = spawn_timer + 30
		#tile_reset() #TODO path to tile_reset()
		
#		if gen_count == 50:
#			get_tree().paused = true
#			emit_signal("game_paused_byScript")


#func tile_reset():
#	for tile in $TileMap.get_used_cells_by_id(3):
#		$TileMap.set_cellv(tile, 2)


func print_population_status():
	spawned_ants = 0
	living_ants = 0
	for child in $Population.get_children():
		if child.get_is_spawned():
			spawned_ants = spawned_ants +1
		if !child.is_dead:
			living_ants = living_ants +1
	#Global.spawned_ants = living_ants
	emit_signal("spawned_ants_label", spawned_ants)
	emit_signal("living_ants_label", living_ants)
#	if living_ants > 6 && !ant_count:
#		if living_ants_old != living_ants:
#			living_ants_old = living_ants
#			print("Ants left: ", living_ants)
#	elif !ant_count:
#		ant_count = true
#		print("Only ", living_ants, " Ants left: ")
#		emit_signal("last_ants")
		
#	var all_fitnesses : Array
#	if everybody_ready:
#		for child in $Population.get_children():
#			all_fitnesses.push_back(child.get_node("Organism").get_fitness())
#		print("All Fitnesses: ", all_fitnesses)
#		all_fitnesses.sort()
#		print("All Fitnesses: ", all_fitnesses)


func _on_GUI_btn_KillAllAnts_pressed():
	for child in $Population.get_children():
		child.killThisOrganism(4)
	#tile_reset() #TODO tilereset


#############################################################################
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
