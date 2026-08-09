extends Node2D

@export var area: Area2D

var mouse_position: Vector2


func _process(_delta: float) -> void:
    mouse_position = CollisionUtil.get_mouse_position()
    area.global_position = mouse_position


func _on_area_2d_area_entered(_area: Area2D) -> void:
    print("Emitting mouse_collision ", _area.collision_layer)
    SignalBus.emit_signal("mouse_collision", _area.collision_layer)
