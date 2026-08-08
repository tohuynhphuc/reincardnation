class_name GameManager
extends Node

const SIN_MAX: int = 100
const SIN_MIN: int = 0

@export var sin_bars: Array[DeadlySin]
@export var card_position: Marker2D
@export var cards: Node2D

var sin_scores: Array[int]

var all_prompts_list: Array[Dictionary]


func _ready() -> void:
    cards.position = card_position.position
    if not check_sins_before_start():
        printerr("SINS ARE INCORRECTLY INITIALIZED. Check GameManager!")

    extract_prompts_from_jsons()

    print(all_prompts_list[0])
    cards.add_child(PromptCard.new_card(all_prompts_list[0]))


func extract_prompts_from_jsons() -> void:
    var temp_array = JSON.parse_string(
        FileAccess.open("res://assets/prompts/all_test.json", FileAccess.READ).get_as_text()
    ) as Array

    for value in temp_array:
        all_prompts_list.append(value)

    ### Old code: (not working)
    # for prompt_json_path in Constants.PROMPT_JSONS:
    #     var parsed_prompt_card = JSONConverter.parse(
    #         FileAccess.open(prompt_json_path, FileAccess.READ).get_as_text(),
    #         PromptCardResource,
    #     ) as PromptCardResource
    #     all_prompts_list.all_prompts_json_list.append(parsed_prompt_card)
    #     print(parsed_prompt_card.prompt_text)


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
