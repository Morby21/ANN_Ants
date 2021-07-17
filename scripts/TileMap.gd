extends TileMap

var tile_position
var draw_tiles = false
var selected_tile: int


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true) #HACK Nötig?


func _physics_process(delta):
	if draw_tiles:
		selected_tile = Global.selected_tile
		tile_position = world_to_map(get_global_mouse_position())
		set_cellv(tile_position, selected_tile)
		#update_bitmask_area(tile) #HACK need to use for collision, no?


func _input(event):
	if event.is_action_pressed("MouseClick_Left"):
		draw_tiles = true
	if event.is_action_released("MouseClick_Left"):
		draw_tiles = false


#func _input(event):
#	if event.is_action_pressed("MouseClick_Left"):
#		var tile = world_to_map(get_global_mouse_position()) #event.position
#		set_cellv(tile, 4)
