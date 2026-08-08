extends Node

enum SINS {
    GLUTTONY,
    LUST,
    GREED,
    SLOTH,
    WRATH,
    ENVY,
    PRIDE,
}

const SCENE_PATHS: Dictionary = {
    "main_game": "uid://co6ce1b36a1bw",
    "all_prompts_tres": "uid://cdwrycfpxc8ob",
    "prompt_card": "uid://bycwn87hnput0",
}

const PROMPT_TEXT = "prompt_text"
const CHOICE_1_TEXT = "choice_one_text"
const CHOICE_2_TEXT = "choice_two_text"
const CHOICE_1_CONSQ = "choice_one_consequences"
const CHOICE_2_CONSQ = "choice_two_consequences"

const PROMPT_JSONS: Array[String] = [
    "res://assets/prompts/test1.json",
    "res://assets/prompts/test2.json",
    "res://assets/prompts/test3.json",
]

const SINS_NAME: Dictionary[SINS, String] = {
    SINS.GLUTTONY: "Gluttony",
    SINS.LUST: "Lust",
    SINS.GREED: "Greed",
    SINS.SLOTH: "Sloth",
    SINS.WRATH: "Wrath",
    SINS.ENVY: "Envy",
    SINS.PRIDE: "Pride",
}

const SINS_TO_ENUM: Dictionary[String, SINS] = {
    "Gluttony": SINS.GLUTTONY,
    "Lust": SINS.LUST,
    "Greed": SINS.GREED,
    "Sloth": SINS.SLOTH,
    "Wrath": SINS.WRATH,
    "Envy": SINS.ENVY,
    "Pride": SINS.PRIDE,
}
