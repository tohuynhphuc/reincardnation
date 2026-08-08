class_name PromptCard
extends Node2D

const PROMPT_CARD_SCENE = preload(Constants.SCENE_PATHS.prompt_card)

@export var main_prompt: RichTextLabel
@export var choice_one: Label
@export var choice_two: Label

# @export var prompt_card: Dictionary
var choice_1_consequences: Dictionary[Constants.SINS, int]
var choice_2_consequences: Dictionary[Constants.SINS, int]


static func new_card(card_info: Dictionary) -> PromptCard:
    var card: PromptCard = PROMPT_CARD_SCENE.instantiate()
    card.load_card(card_info)
    return card


func load_card(card_info: Dictionary) -> void:
    main_prompt.text = card_info[Constants.PROMPT_TEXT]
    choice_one.text = card_info[Constants.CHOICE_1_TEXT]
    choice_two.text = card_info[Constants.CHOICE_2_TEXT]

    var extracted_choice_1_consq: Dictionary = card_info[Constants.CHOICE_1_CONSQ]
    for _sin in extracted_choice_1_consq.keys():
        choice_1_consequences[Constants.SINS_TO_ENUM[_sin]] = extracted_choice_1_consq[_sin]

    var extracted_choice_2_consq: Dictionary = card_info[Constants.CHOICE_2_CONSQ]
    for _sin in extracted_choice_2_consq.keys():
        choice_2_consequences[Constants.SINS_TO_ENUM[_sin]] = extracted_choice_2_consq[_sin]


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        print("Mouse Clicked/Unclicked at ", event.position)
    elif event is InputEventMouseMotion:
        print("Mouse Motion at: ", event.position)

    print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
