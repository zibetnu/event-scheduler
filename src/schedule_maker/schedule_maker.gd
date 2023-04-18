extends ScheduleScreen


func _on_export_button_pressed() -> void:
	var export_string := ""
	var days: Array[Node] = %DayContainer.get_children()
	var i := 0
	while i < len(days):
		export_string += days[i].get_day_hex_string()
		i += 1
		if i < len(days):
			export_string += " "

	%ExportText.text = export_string
	%ExportPopup.popup_centered()
