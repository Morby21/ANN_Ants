extends Node2D



func _enter_tree():
	self.add_child(Global.CanvasGUI_Instance)
	self.add_child(Global.Ants_Population_Instance)

func _exit_tree():
	self.remove_child(Global.CanvasGUI_Instance)
	self.remove_child(Global.Ants_Population_Instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_TileMap():
	return get_node("TileMap")


func get_HivePosition():
	return $Objects/Object_Hive.position


var dragging = false
var click_radius = 250 # Size of the sprite.

#FIXME Cameraoom makes problems at dragging the hive
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if (event.position - get_node("Objects").get_node("Object_Hive").position).length() < click_radius:
			# Start dragging if the click is on the sprite.
			if not dragging and event.pressed:
				dragging = true
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the sprite with the mouse.
		get_node("Objects").get_node("Object_Hive").position = event.position
