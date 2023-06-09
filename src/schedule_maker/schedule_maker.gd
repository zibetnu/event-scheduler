extends ScheduleScreen


func _ready() -> void:
	for i in range(_serializers.size()):
		%SerializerSelector.add_item(_serializers[i].get_title())
		%SerializerSelector.set_item_tooltip(i, _serializers[i].get_unserialize_requirements())


func _on_export_button_pressed() -> void:
	if _serializers.size() == 0:
		%ErrorDialog.dialog_text = "No schedule serializers found. Cannot export schedule."
		%ErrorDialog.popup_centered()
		return

	_update_export_text()
	%ExportPopup.popup_centered()


func _on_export_popup_confirmed() -> void:
	DisplayServer.clipboard_set(%ExportText.text)


func _on_serializer_selector_item_selected(_index: int) -> void:
	_update_export_text()


func _update_export_text() -> void:
	var schedule_array := %DayContainer.get_children().map(func(day): return day.get_day_array())
	%ExportText.text = _serializers[%SerializerSelector.get_selected()].serialize(schedule_array)
