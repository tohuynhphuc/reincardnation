extends Node2D


## layer > mask
func is_layer_in_mask(layer: int, mask: int) -> bool:
    return (layer & mask) == mask


func get_mouse_position() -> Vector2:
    return get_canvas_transform().affine_inverse() * get_viewport().get_mouse_position()
