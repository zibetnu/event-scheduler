extends ScrollContainer


@export var back_path: String


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(back_path)


func _on_import_button_pressed() -> void:
	%ImportPopup.popup_centered()


func _on_import_popup_confirmed() -> void:
	# TODO: add input validation.
	var day_hex_strings: PackedStringArray = %ImportText.text.split(" ")
	var i := 0
	for day in %Week.get_days():
		day.add_day_hex_string(day_hex_strings[i])
		i += 1

	%ImportText.text = ""


func _on_display_button_pressed() -> void:
	for day in %Week.get_days():
		day.display_day_hex_strings()
