class_name PromptCardResource
extends Resource

@export var prompt_text: String = "What do you do?"
@export var choice_one_text: String = "Choice A"
@export var choice_two_text: String = "Choice B"
@export var choice_one_consequences: Dictionary[String, int] = {
    Constants.SINS_NAME[Constants.SINS.GLUTTONY]: 0,
    Constants.SINS_NAME[Constants.SINS.LUST]: 0,
}
@export var choice_two_consequences: Dictionary[String, int] = {
    Constants.SINS_NAME[Constants.SINS.GLUTTONY]: 0,
    Constants.SINS_NAME[Constants.SINS.LUST]: 0,
}
