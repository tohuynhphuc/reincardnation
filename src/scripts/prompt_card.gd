class_name PromptCard
extends Node2D

const PROMPT_CARD_SCENE = preload(Constants.SCENE_PATHS.prompt_card)

@export var main_prompt: RichTextLabel
@export var choice_one: Label
@export var choice_two: Label

@export_flags_2d_physics var mouse: int

# @export var prompt_card: Dictionary
var choice_1_consequences: Dictionary[Constants.SINS, int]
var choice_2_consequences: Dictionary[Constants.SINS, int]

var is_mouse_entered: bool = false
var is_animation_playing: bool = false
var mouse_original_position: Vector2 = Vector2.ZERO


static func new_card(card_info: Dictionary) -> PromptCard:
    var card: PromptCard = PROMPT_CARD_SCENE.instantiate()
    card.load_card(card_info)
    return card


func _input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("mouse_click") and is_mouse_entered:
        # Mouse is hovering over card and click
        pass
        mouse_original_position = CollisionUtil.get_mouse_position()
    elif Input.is_action_pressed("mouse_click") and is_animation_playing:
        # Mouse is holding, animation playing (mouse could be out of the card,
        # but as long as holding then it still counts)
        pass
    elif Input.is_action_just_released("mouse_click"):
        # Mouse drop
        is_animation_playing = false
        mouse_original_position = Vector2.ZERO


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


func _on_area_2d_area_entered(area: Area2D) -> void:
    if CollisionUtil.is_layer_in_mask(area.collision_layer, mouse):
        print("entered")
        is_mouse_entered = true


func _on_area_2d_area_exited(area: Area2D) -> void:
    if CollisionUtil.is_layer_in_mask(area.collision_layer, mouse):
        print("exited")
        is_mouse_entered = false
