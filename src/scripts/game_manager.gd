class_name GameManager
extends Node

const SIN_MAX: int = 100
const SIN_MIN: int = 0

const STARTING_CARD: String = "id1_first_day_of_school"

@export var sin_bars: Array[DeadlySin]
@export var card_position: Marker2D
@export var cards: Node2D

@export var choice_one_area: Area2D
@export var choice_one_label: RichTextLabel
@export var choice_two_area: Area2D
@export var choice_two_label: RichTextLabel

@export_flags_2d_physics var choice_one_layer: int
@export_flags_2d_physics var choice_two_layer: int

var sin_scores: Array[int]

var all_prompts_list: Dictionary

## Initialize this value with the FIRST CARD (Hardcoded)
var current_card_id: String = "id1_first_day_of_school"
var need_change_card: bool = true
var is_holding_card: bool = false


func _ready() -> void:
    cards.position = card_position.position
    if not check_sins_before_start():
        printerr("SINS ARE INCORRECTLY INITIALIZED. Check GameManager!")
    print(sin_scores)

    extract_prompts_from_jsons()

    # setup_card(current_card_id)
    SignalBus.mouse_collision.connect(confirm_choice)
    SignalBus.holding_card.connect(set_holding_card)


func _process(delta: float) -> void:
    if need_change_card:
        setup_card(current_card_id)
        need_change_card = false


func set_holding_card(is_holding: bool) -> void:
    is_holding_card = is_holding


func setup_card(id: String) -> bool:
    if not all_prompts_list.has(id):
        return false
    var card_info = all_prompts_list[id]

    var card: PromptCard = PromptCard.new_card(card_info)

    cards.add_child(card)
    choice_one_label.text = card_info[Constants.CHOICE_1_TEXT]
    choice_two_label.text = card_info[Constants.CHOICE_2_TEXT]

    return true


func confirm_choice(layer: int) -> void:
    if not is_holding_card:
        # Player is still holding the card. Don't need to check anything
        # or
        # Player is not holding any card.
        print("Fail check here")
        return

    while Input.is_action_pressed("mouse_click"):
        await get_tree().create_timer(0.2).timeout

    # Player has released the card
    var card_info = all_prompts_list[current_card_id]
    if CollisionUtil.is_layer_in_mask(choice_one_layer, layer):
        print("Choice one is made")
        var consequences = card_info[Constants.CHOICE_1_CONSQ] as Dictionary
        for i in consequences.size():
            print(consequences.keys()[i], " ", consequences.values()[i])
            modify_sin(Constants.SINS_TO_ENUM[consequences.keys()[i]], consequences.values()[i])
    elif CollisionUtil.is_layer_in_mask(choice_two_layer, layer):
        print("Choice two is made")
        var consequences = card_info[Constants.CHOICE_2_CONSQ] as Dictionary
        for i in consequences.size():
            print(consequences.keys()[i], " ", consequences.values()[i])
            modify_sin(Constants.SINS_TO_ENUM[consequences.keys()[i]], consequences.values()[i])
    else:
        printerr("Nothing should be here. Check Game Manager")
        return

    var next_questions: Array = card_info[Constants.NEXT_QUESTIONS]
    current_card_id = next_questions[randi_range(0, next_questions.size() - 1)]
    need_change_card = true


func extract_prompts_from_jsons() -> void:
    var temp_dict = JSON.parse_string(
        FileAccess.open("res://assets/prompts/all_test.json", FileAccess.READ).get_as_text()
    ) as Dictionary

    all_prompts_list = temp_dict


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
