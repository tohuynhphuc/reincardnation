extends Button

@export var game_manager: GameManager


func _ready() -> void:
    pressed.connect(_on_pressed)


func _on_pressed() -> void:
    var chosen := randi_range(0, 6) as Constants.SINS
    var value := randi_range(-20, 20)
    print(chosen, value)
    game_manager.modify_sin(chosen, value)
