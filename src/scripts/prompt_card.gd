extends Node2D

@export var main_prompt: RichTextLabel
@export var choice_one: Label
@export var choice_two: Label

@export var prompt_card: PromptCardResource

var choice_one_consequences: Dictionary[Constants.SINS, int]
var choice_two_consequences: Dictionary[Constants.SINS, int]


func load_card() -> void:
    pass
