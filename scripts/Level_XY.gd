extends Node2D

var dragging = false
var click_radius_ant = 40 # Size of the sprite.
var click_radius_hive = 250 # Size of the sprite.

func _enter_tree():
	self.add_child(Global.CanvasGUI_Instance)
	self.add_child(Global.Ants_Population_Instance)

func _exit_tree():
	self.remove_child(Global.CanvasGUI_Instance)
	self.remove_child(Global.Ants_Population_Instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Ants_Population").new_level_started()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_TileMap():
	return get_node("TileMap")


func get_HivePosition():
	return $Objects/Object_Hive.position


func _input(event):
	if Global.tool_is_selecting:
		var Ants_Population = get_node("Ants_Population")
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			Ants_Population.unselect_all_ants()
			var arr_all_ant_positions = Ants_Population.get_all_ant_positions()
			var index = 0
			for ant in arr_all_ant_positions:
				if (get_viewport().canvas_transform.affine_inverse().xform(event.position) - arr_all_ant_positions[index]).length() < click_radius_ant:
					Ants_Population.selected_ant_position(index)
				index = index +1
	
	if Global.tool_is_dragging:
		# Get Position for draging but the zoom: https://www.reddit.com/r/godot/comments/gj4yev/convert_eventposition_mouse_to_local_position_in/
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if (get_viewport().canvas_transform.affine_inverse().xform(event.position) - get_node("Objects").get_node("Object_Hive").position).length() < click_radius_hive:
				# Start dragging if the click is on the sprite.
				if not dragging and event.pressed:
					dragging = true
			# Stop dragging if the button is released.
			if dragging and not event.pressed:
				dragging = false
		
		if event is InputEventMouseMotion and dragging:
			# While dragging, move the sprite with the mouse.
			#get_node("Objects").get_node("Object_Hive").position = event.position
			get_node("Objects").get_node("Object_Hive").position = get_viewport().canvas_transform.affine_inverse().xform(event.position)
