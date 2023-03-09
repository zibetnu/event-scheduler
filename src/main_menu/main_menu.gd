extends MarginContainer


@export var comparer_path: String
@export var maker_path: String


func _on_compare_schedules_pressed():
	get_tree().change_scene_to_file(comparer_path)


func _on_make_schedule_pressed():
	get_tree().change_scene_to_file(maker_path)
