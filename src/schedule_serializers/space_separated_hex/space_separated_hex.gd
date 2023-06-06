extends ScheduleSerializer


const _BOOL_PER_HEX = 4
const _BOOL_TO_HEX := {
	[false, false, false, false]: "0",
	[false, false, false, true]: "1",
	[false, false, true, false]: "2",
	[false, false, true, true]: "3",
	[false, true, false, false]: "4",
	[false, true, false, true]: "5",
	[false, true, true, false]: "6",
	[false, true, true, true]: "7",
	[true, false, false, false]: "8",
	[true, false, false, true]: "9",
	[true, false, true, false]: "A",
	[true, false, true, true]: "B",
	[true, true, false, false]: "C",
	[true, true, false, true]: "D",
	[true, true, true, false]: "E",
	[true, true, true, true]: "F",
}


func can_unserialize(schedule_string: String) -> bool:
	var day_strings := schedule_string.split(" ")
	if day_strings.size() != 7:
		return false

	for day_string in day_strings:
		if day_string.length() != 12:
			return false

		for character in day_string:
			if character not in _BOOL_TO_HEX.values():
				return false

	return true


func get_title() -> String:
	return "Space-separated hexadecimal"


func get_unserialize_requirements() -> String:
	return "7 space-separated sets of 12 characters, with each character being 0-9 or A-F"


func serialize(schedule_array: Array) -> String:
	var schedule_string := ""
	for day_array in schedule_array:
		var i := 0
		while i < len(day_array):
			schedule_string += _BOOL_TO_HEX[day_array.slice(i, i + _BOOL_PER_HEX)]
			i += _BOOL_PER_HEX

		schedule_string += " "

	return schedule_string.strip_edges()


func unserialize(schedule_string: String) -> Array:
	var schedule_array: Array[Array] = []

	var _hex_to_bool = {}
	for key in _BOOL_TO_HEX:
		_hex_to_bool[_BOOL_TO_HEX[key]] = key

	for day_string in schedule_string.split(" "):
		var day_array := []
		for character in day_string:
			day_array += _hex_to_bool[character]

		schedule_array.append(day_array)

	return schedule_array
