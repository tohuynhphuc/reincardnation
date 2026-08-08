extends Node2D

@export var area: Area2D

var mouse_position: Vector2


func _process(_delta: float) -> void:
    mouse_position = CollisionUtil.get_mouse_position()
    area.global_position = mouse_position
