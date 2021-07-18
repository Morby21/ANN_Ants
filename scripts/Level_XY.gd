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
