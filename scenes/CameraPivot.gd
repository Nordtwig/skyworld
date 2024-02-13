extends Marker3D

var player: Player = null

@onready var camera: Camera3D = $Camera3D


func _ready() -> void:
    player = get_tree().get_first_node_in_group("player")

    if player:
        global_position = player.global_position


func _process(delta) -> void:
    if player:
        global_position = lerp(global_position, player.global_position, 0.5)
