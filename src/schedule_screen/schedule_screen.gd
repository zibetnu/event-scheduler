class_name ScheduleScreen
extends ScrollContainer


@export var back_path: String


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(back_path)
