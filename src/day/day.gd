extends PanelContainer


@export var day_name := "Day Name"

@onready var _day_label := %DayLabel
@onready var _slots := %Slots.get_children()

var _day_hex_strings: Array[String] = []


func _ready() -> void:
	_day_label.text = day_name
	var i := 0
	var hours := ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
	var minutes := ["00", "30"]
	var meridians := ["AM", "PM"]
	for slot in _slots:
		slot.set_time_label("%2s:%s %s" % [
				hours[(i / len(minutes)) % len(hours)],
				minutes[i % len(minutes)],
				meridians[(i / (len(hours) * len(minutes))) % len(meridians)]
		])
		i += 1


func add_day_hex_string(day_hex_string: String) -> void:
	_day_hex_strings.append(day_hex_string)


func get_day_hex_string() -> String:
	var bit_string := ""
	for slot in _slots:
		bit_string += str(int(slot.is_selected()))

	return BitHexConverter.bits_to_hex(bit_string)


func display_day_hex_strings() -> void:
	var day_bit_strings: Array[String] = []
	for day_hex_string in _day_hex_strings:
		day_bit_strings.append(BitHexConverter.hex_to_bits(day_hex_string))

	var i := 0
	for slot in _slots:
		var value := 0
		for day_bit_string in day_bit_strings:
			value += int(day_bit_string[i])

		slot.set_value(value, len(_day_hex_strings))
		i += 1
