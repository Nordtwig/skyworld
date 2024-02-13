extends CharacterBody3D
class_name Player

@export var move_speed: float = 10.0
@export var fall_acceleration: float = 6.0

var target_velocity: Vector3 = Vector3.ZERO


func _physics_process(delta) -> void:
    var direction = Vector3.ZERO

    if Input.is_action_pressed("move_left"):
        direction.x += 1
    if Input.is_action_pressed("move_right"):
        direction.x -= 1
    if Input.is_action_pressed("move_forward"):
        direction.z += 1
    if Input.is_action_pressed("move_backward"):
        direction.z -= 1

    if direction != Vector3.ZERO:
        direction = direction.normalized()

    target_velocity.x = direction.x * move_speed
    target_velocity.z = direction.z * move_speed

    if not is_on_floor():
        target_velocity.y = target_velocity.y - (fall_acceleration * delta)
    
    velocity = target_velocity
    move_and_slide()
