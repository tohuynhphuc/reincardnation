class_name GameManager
extends Node

const SIN_MAX: int = 100
const SIN_MIN: int = 0

@export var sin_bars: Array[DeadlySin]

var sin_scores: Array[int]


func _ready() -> void:
    if not check_sins_before_start():
        printerr("SINS ARE INCORRECTLY INITIALIZED. Check GameManager!")

    print(JSONConverter.stringify(preload("res://resources/prompt_card.tres"), "  "))
    var parsed_result: PromptCardResource = JSONConverter.parse(
        FileAccess.open("res://assets/prompts/basic.json", FileAccess.READ).get_as_text(),
        PromptCardResource,
    )
    print(parsed_result.prompt_text)


func modify_sin(selected_sin: Constants.SINS, change_by: int) -> void:
    var new_value: int = clampi(sin_scores[selected_sin] + change_by, SIN_MIN, SIN_MAX)
    sin_scores[selected_sin] = new_value
    sin_bars[selected_sin].progress_bar_updated.emit(new_value)


func check_sins_before_start() -> bool:
    var sin_values := Constants.SINS.values()
    var sin_bars_size: int = sin_bars.size()

    if sin_bars_size != sin_values.size():
        return false

    sin_scores.resize(sin_bars_size)

    for i in sin_bars_size:
        if sin_bars[i].sin_name != sin_values[i]:
            return false
        sin_scores[i] = sin_bars[i].progress_bar.value as int

    return true
