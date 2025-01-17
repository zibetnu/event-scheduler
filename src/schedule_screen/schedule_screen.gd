class_name ScheduleScreen
extends Control


@export var back_path: String
@export var serializers_path := "res://src/schedule_serializers/"

# _serializers is used in scripts that extend ScheduleScreen.
@warning_ignore("unused_private_class_variable")
@onready var _serializers := _get_serializers_at(serializers_path)


func _exit_tree() -> void:
	for serializer in _serializers:
		serializer.queue_free()


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(back_path)


func _get_serializers_at(path: String) -> Array[ScheduleSerializer]:
	var serializers: Array[ScheduleSerializer] = []
	for dir_name in DirAccess.get_directories_at(path):
		serializers.append_array(_get_serializers_at(path + dir_name + "/"))

	for file_name in DirAccess.get_files_at(path):
		# https://github.com/godotengine/godot/issues/66014
		file_name = file_name.trim_suffix(".remap")

		var file := load(path + file_name)
		if not file.is_class("PackedScene"):
			continue

		var instance = file.instantiate()
		if not instance is ScheduleSerializer:
			instance.queue_free()
			continue

		serializers.append(instance)

	return serializers
