class_name TopCamera
extends KinematicBody2D

export var speed := 500
export var angular_speed := 2.0
var velocity_y : Vector2
var velocity_x : Vector2

func _physics_process(_delta):
	
	if Input.get_action_strength("Up"):
		velocity_y = Input.get_action_strength("Up") * transform.y * speed * -1
	elif Input.get_action_strength("Down"):
		velocity_y = Input.get_action_strength("Down") * transform.y * speed
	else:
		velocity_y = transform.y * 0
	
	move_and_slide(velocity_y)
		
	if Input.get_action_strength("Right"):
		velocity_x = Input.get_action_strength("Right") * transform.x * speed
	elif Input.get_action_strength("Left"):
		velocity_x = Input.get_action_strength("Left") * transform.x * speed * -1
	else:
		velocity_x = transform.x * 0
	
	move_and_slide(velocity_x)

#--------------------------
#https://godotengine.org/qa/24969/how-to-drag-camera-with-mouse
var dragging = false

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = get_global_mouse_position()
