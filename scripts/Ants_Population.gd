extends Node

signal new_generation
signal generation_count_label(gen_count)
signal living_ants_label(a)
signal spawned_ants_label(a)

export var spawn_timer_value : int = 30

var everybody_ready = false
var spawn_timer : int
var spawned_ants
var living_ants
var living_ants_old
var gen_count = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var GUI = get_parent().get_node("GUI")
	connect("generation_count_label", GUI, "_on_Ants_World_generation_count_label")
	connect("living_ants_label", GUI, "_on_Ants_World_living_ants_label")
	connect("spawned_ants_label", GUI, "_on_Ants_World_spawned_ants_label")
	GUI.connect("btn_KillAllAnts_pressed", self, "_on_GUI_btn_KillAllAnts_pressed")
	GUI.spawned_ants_max = $Population.size


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
		if gen_count > 5: #TODO: replace 5 with a variable
			replace_stupid_ants()
		emit_signal("new_generation")#TODO wo ging/ging das Signal mal hin?
		$Population.next_generation()
		gen_count = gen_count + 1
		emit_signal("generation_count_label", gen_count)
		spawn_timer = 0
		for ant in $Population.get_children():
			ant.reset()
			#ant.respawn(spawn_timer)
			ant.trigger_respawn(spawn_timer)
			spawn_timer = spawn_timer + spawn_timer_value
		tile_reset() 


func tile_reset(): #TODO gehört eigentlich nicht in diese Scene.
	var AntsTileMap = get_parent().get_TileMap()
	for tile in AntsTileMap.get_used_cells_by_id(3):
		AntsTileMap.set_cellv(tile, 2)


func print_population_status():
	spawned_ants = 0
	living_ants = 0
	for child in $Population.get_children():
		if child.get_is_spawned():
			spawned_ants = spawned_ants +1
		if !child.is_dead:
			living_ants = living_ants +1
	emit_signal("spawned_ants_label", spawned_ants)
	emit_signal("living_ants_label", living_ants)


func _on_GUI_btn_KillAllAnts_pressed():
	for child in $Population.get_children():
		child.killThisOrganism(4)
	tile_reset() 


func replace_stupid_ants():
	var best_ant : Ant = $Population.get_best()
	var fitness_of_best_ant = best_ant.get_node("Organism").get_fitness()
	var stupid_ants : Array
	var smart_ants : Array
	for child in $Population.get_children():
		var fitness_of_ant = child.get_node("Organism").get_fitness()
		if fitness_of_ant < fitness_of_best_ant / 10: #TODO: replace 10 with a variable
			stupid_ants.append(child)
		if fitness_of_ant > fitness_of_best_ant / 10: #TODO: replace 10 with a variable (can be a different one than the one above)
			smart_ants.append(child)
	for ant in stupid_ants:
		var randomly_picked_smart_dna = smart_ants[randi() % smart_ants.size()]
		ant.get_node("Organism").set_dna(randomly_picked_smart_dna)








