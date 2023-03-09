extends ScrollContainer


@export var back_path: String


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(back_path)


func _on_export_button_pressed() -> void:
	var export_string := ""
	var days: Array[Node] = %Week.get_days()
	var i := 0
	while i < len(days):
		export_string += days[i].get_day_hex_string()
		i += 1
		if i < len(days):
			export_string += " "

	%ExportText.text = export_string
	%ExportPopup.popup_centered()
