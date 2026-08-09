class_name PromptCard
extends Node2D

const PROMPT_CARD_SCENE = preload(Constants.SCENE_PATHS.prompt_card)

const SWIPE_LEFT_ANIM = "swipe_left"
const SWIPE_RIGHT_ANIM = "swipe_right"

@export var main_prompt: RichTextLabel
@export var choice_one: Label
@export var choice_two: Label

@export var animation_player: AnimationPlayer

@export_flags_2d_physics var mouse: int

# @export var prompt_card: Dictionary
var choice_1_consequences: Dictionary[Constants.SINS, int]
var choice_2_consequences: Dictionary[Constants.SINS, int]

var is_mouse_entered: bool = false

# var is_animation_playing: bool = false
var position_difference: Vector2 = Vector2.ZERO


# var previous_percentage: float = 0
# var mouse_movement_threshold: float = 100
static func new_card(card_info: Dictionary) -> PromptCard:
    var card: PromptCard = PROMPT_CARD_SCENE.instantiate()
    card.load_card(card_info)
    return card


func _input(event: InputEvent) -> void:
    if not is_mouse_entered:
        return

    if Input.is_action_just_pressed("mouse_click"):
        print("Case 1")

        #     # Mouse is hovering over card and click
        # var position_difference = CollisionUtil.get_mouse_position()
        position_difference = global_position - CollisionUtil.get_mouse_position()
        # global_position = CollisionUtil.get_mouse_position()
    #     is_animation_playing = true
    #     previous_percentage = 0

    elif Input.is_action_pressed("mouse_click"):
        global_position = CollisionUtil.get_mouse_position() + position_difference

    #     # Mouse is holding, animation playing (mouse could be out of the card,
    #     # but as long as holding then it still counts)
    #     var current_mouse_position = CollisionUtil.get_mouse_position()
    #     var mouse_move_distance = current_mouse_position.x - position_difference.x
    #     if mouse_move_distance < 0 and mouse_move_distance > -mouse_movement_threshold:
    #         # Moving to the left
    #         print("Playing")
    #         animation_player.play_section(SWIPE_LEFT_ANIM, 0, 1, -1, 2)
    #         animation_player.get
    #     elif mouse_move_distance > 0 and mouse_move_distance < mouse_movement_threshold:
    #         animation_player.play_section(SWIPE_RIGHT_ANIM, 0, 1, -1, 2)

    # elif Input.is_action_just_released("mouse_click"):
    #     print("Case 3")

    #     # Mouse drop
    #     is_animation_playing = false
    #     position_difference = Vector2.ZERO

    # else:
    #     print("Case 4???")


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


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    pass
    # if anim_name == "swipe_left":
    #     is_animation_playing = false
