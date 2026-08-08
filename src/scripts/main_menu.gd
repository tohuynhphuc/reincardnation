extends Node2D

@export var start_button: Button


func _ready() -> void:
    start_button.pressed.connect(_on_start_game)


func _on_start_game() -> void:
    SceneManager.load_scene(Constants.SCENE_PATHS.main_game)
