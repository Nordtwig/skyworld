extends CharacterBody3D
class_name Player

@export var run_speed: float = 20.0
@export var walk_speed: float = 10.0
@export var jump_force: float = 200.0
@export var gravity: float = 10.0

var current_speed: float
var direction: Vector3
var target_velocity: Vector3 = Vector3.ZERO
var acceleration: float = 6.0


func _physics_process(delta) -> void:
    direction = Vector3.ZERO

    if Input.is_action_just_pressed("quit"):
        get_tree().quit()
    if Input.is_action_just_pressed("restart"):
        get_tree().reload_current_scene()

    if Input.is_action_pressed("move_left") ||  Input.is_action_pressed("move_right") ||\
        Input.is_action_pressed("move_forward") || Input.is_action_pressed("move_backward"):
        
        var horizontal_rotation = $CamRoot/h.global_transform.basis.get_euler().y

        direction = Vector3(
            Input.get_action_strength("move_left") - Input.get_action_strength("move_right"),
            0,
            Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
        ).rotated(Vector3.UP, horizontal_rotation)
        
        if direction != Vector3.ZERO:
            direction = direction.normalized()
        
        $Mesh.rotation.y = lerp($Mesh.rotation.y, $CamRoot/h.rotation.y, 5.0 * delta)
        
        if Input.is_action_pressed("sprint"):
            current_speed = run_speed
        else: 
            current_speed = walk_speed
    else:
        current_speed = 0

    target_velocity.x = direction.x * current_speed
    target_velocity.z = direction.z * current_speed

    if is_on_floor():
        target_velocity.y = 0
        if Input.is_action_just_pressed("jump"):
            target_velocity.y += jump_force

    if not is_on_floor():
        target_velocity.y = target_velocity.y - gravity

    velocity = lerp(velocity, target_velocity, delta * acceleration)
    move_and_slide()
