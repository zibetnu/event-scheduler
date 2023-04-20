extends ScheduleScreen


func _on_import_button_pressed() -> void:
	%ImportPopup.popup_centered()


func _on_import_popup_confirmed() -> void:
	var day_hex_strings: PackedStringArray = %ImportText.text.split(" ")

	if len(day_hex_strings) != 7:
		%ErrorDialog.popup_centered()
		return

	for day_hex_string in day_hex_strings:
		if len(day_hex_string) != 12:
			%ErrorDialog.popup_centered()
			return

		for character in day_hex_string:
			if character not in BitHexConverter.VALID_HEX_CHARACTERS:
				%ErrorDialog.popup_centered()
				return

	var i := 0
	for day in %DayContainer.get_children():
		day.add_day_hex_string(day_hex_strings[i])
		day.display_day_hex_strings()
		i += 1

	%ImportText.text = ""
