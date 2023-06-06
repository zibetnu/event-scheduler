extends ScheduleScreen


var _schedule_arrays: Array[Array] = []


func _ready() -> void:
	for i in range(_serializers.size()):
		%SerializerSelector.add_item(_serializers[i].get_title())
		%SerializerSelector.set_item_tooltip(i, _serializers[i].get_unserialize_requirements())

	_update_selectable_items()


func _on_import_button_pressed() -> void:
	if _serializers.size() == 0:
		%ErrorDialog.dialog_text = "No schedule serializers found. Cannot import schedule."
		%ErrorDialog.popup_centered()
		return

	%ImportPopup.popup_centered()


func _on_confirm_button_pressed() -> void:
	var selected_serializer := _serializers[%SerializerSelector.get_selected()]
	_schedule_arrays.append(selected_serializer.unserialize(%ImportText.text))
	_reset_popup()

	var i := 0
	for day in %DayContainer.get_children():
		day.display_day_arrays(_schedule_arrays.map(func(schedule_array): return schedule_array[i]))
		i += 1


func _on_cancel_button_pressed() -> void:
	%ImportPopup.hide()


func _on_import_popup_about_to_popup() -> void:
	_reset_popup()


func _on_import_popup_close_requested() -> void:
	%ImportPopup.hide()


func _on_import_text_text_changed() -> void:
	_update_selectable_items()


func _reset_popup() -> void:
	%ImportText.text = ""
	_update_selectable_items()


func _update_selectable_items() -> void:
	for i in range(_serializers.size()):
		%SerializerSelector.set_item_disabled(
				i, not _serializers[i].can_unserialize(%ImportText.text)
		)

	%SerializerSelector.select(%SerializerSelector.get_selectable_item())
	%ConfirmButton.disabled = %SerializerSelector.selected == -1
