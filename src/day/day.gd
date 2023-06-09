extends PanelContainer


@export var day_name := "Day Name"

@onready var _day_label := %DayLabel
@onready var _slots := %Slots.get_children()


func _ready() -> void:
	_day_label.text = day_name
	var i := 0
	var hours := ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
	var minutes := ["00", "30"]
	var meridians := ["AM", "PM"]
	for slot in _slots:
		@warning_ignore("integer_division")  # The use of integer division is intentional.
		slot.set_time_label("%2s:%s %s" % [
				hours[(i / len(minutes)) % len(hours)],
				minutes[i % len(minutes)],
				meridians[(i / (len(hours) * len(minutes))) % len(meridians)]
		])
		i += 1


func display_day_arrays(day_arrays: Array) -> void:
	var slot_values: Array[int] = []
	slot_values.resize(_slots.size())
	slot_values.fill(0)

	for day_array in day_arrays:
		var i := 0
		while i < day_array.size() and i < slot_values.size():
			slot_values[i] += int(day_array[i])
			i += 1

	var max_value := day_arrays.size()
	for i in range(slot_values.size()):
		_slots[i].set_value(slot_values[i], max_value)


func get_day_array() -> Array:
	return _slots.map(func(slot): return slot.is_selected())
