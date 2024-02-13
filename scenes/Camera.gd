extends Node3D

var camera_rotation_horizontal: float = 0
var camera_rotation_vertical: float = 0
var camera_vertical_minimum: float = -55
var camera_vertical_maximum: float = 75
var horizontal_sensitivity: float = 0.1
var vertical_sensitivity: float = 0.1
var horizontal_acceleration: float = 10
var vertical_acceleration: float = 10

@onready var horizontal: Node3D = $h
@onready var vertical: Node3D = $h/v


func _physics_process(delta) -> void:
    camera_rotation_vertical = clamp(camera_rotation_vertical, camera_vertical_minimum, camera_vertical_maximum)

    horizontal.rotation_degrees.y = lerp(horizontal.rotation_degrees.y, camera_rotation_horizontal, delta * horizontal_acceleration)
    vertical.rotation_degrees.x = lerp(vertical.rotation_degrees.x, camera_rotation_vertical, delta * vertical_acceleration)
 

func _input(event):
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    if event is InputEventMouseMotion:
        camera_rotation_horizontal += -event.relative.x * horizontal_sensitivity
        camera_rotation_vertical += event.relative.y * vertical_sensitivity


