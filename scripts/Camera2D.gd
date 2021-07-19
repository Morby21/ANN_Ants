
extends Camera2D

func _ready():
	_update_zoom(0.25, get_local_mouse_position())
	print("ready")
	
# https://www.braindead.bzh/entry/godot-interactive-camera2d
# Written by Olivier Boucard on Tuesday February 7, 2017
# You can find below a very simple script that you can attach to any Camera2D node within Godot Engine. It provides the following functionality:
#    Moving the camera using the mouse
#    Zoom centered on mouse cursor
#    Rebindable actions through Godot's Input Map
#    Signal emitting if you need to make other nodes react to camera movement or zoom

const MAX_ZOOM_LEVEL = 0.5
const MIN_ZOOM_LEVEL = 6.0
const ZOOM_INCREMENT = 0.25

signal moved()
signal zoomed()

var _current_zoom_level = 4 
var _drag = false

func _input(event):
	if event.is_action_pressed("MouseClick_Middle"):
		_drag = true
	elif event.is_action_released("MouseClick_Middle"):
		_drag = false
	elif event.is_action("Zoom_in"):
		_update_zoom(-ZOOM_INCREMENT, get_local_mouse_position())
	elif event.is_action("Zoom_out"):
		_update_zoom(ZOOM_INCREMENT, get_local_mouse_position())
	elif event is InputEventMouseMotion && _drag:
		set_offset(get_offset() - event.relative*_current_zoom_level)
		emit_signal("moved")

func _update_zoom(incr, zoom_anchor):
	var old_zoom = _current_zoom_level
	_current_zoom_level += incr
	if _current_zoom_level < MAX_ZOOM_LEVEL:
		_current_zoom_level = MAX_ZOOM_LEVEL
	elif _current_zoom_level > MIN_ZOOM_LEVEL:
		_current_zoom_level = MIN_ZOOM_LEVEL
	if old_zoom == _current_zoom_level:
		return
	
	var zoom_center = zoom_anchor - get_offset()
	var ratio = 1-_current_zoom_level/old_zoom
	set_offset(get_offset() + zoom_center*ratio)
	
	set_zoom(Vector2(_current_zoom_level, _current_zoom_level))
	emit_signal("zoomed")
