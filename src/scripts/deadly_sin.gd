class_name DeadlySin
extends Control

signal progress_bar_updated(progress: float)

@export var sin_name: Constants.SINS
@export var progress_bar: ProgressBar
@export var label: Label
@export var name_label: Label

var progress_tween_duration: float = 1


func _ready() -> void:
    name_label.text = Constants.SINS_NAME[sin_name]
    progress_bar_updated.connect(_on_progress_bar_updated)


func _on_progress_bar_updated(progress: float) -> void:
    var progress_bar_tween: Tween = create_tween()
    progress_bar_tween.tween_property(progress_bar, "value", progress, progress_tween_duration)


func _on_progress_bar_value_changed(value: float) -> void:
    label.text = "\n" + str(value as int)
