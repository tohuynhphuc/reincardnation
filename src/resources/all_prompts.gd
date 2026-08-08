class_name AllPromptsResource
extends Resource

@export var all_prompts_json_list: Array[PromptCardResource] = []


func append(res: PromptCardResource) -> void:
    all_prompts_json_list.append(res)
