extends Node


const BITS_PER_HEX = 4
const _BITS_TO_HEX := {
	"0000": "0",
	"0001": "1",
	"0010": "2",
	"0011": "3",
	"0100": "4",
	"0101": "5",
	"0110": "6",
	"0111": "7",
	"1000": "8",
	"1001": "9",
	"1010": "A",
	"1011": "B",
	"1100": "C",
	"1101": "D",
	"1110": "E",
	"1111": "F",
}

var _hex_to_bits = {}


func _ready() -> void:
	for key in _BITS_TO_HEX:
		_hex_to_bits[_BITS_TO_HEX[key]] = key


func bits_to_hex(bit_string: String) -> String:
	var remainder := len(bit_string) % BITS_PER_HEX
	if remainder != 0:
		bit_string = "%0*d" % [len(bit_string) + BITS_PER_HEX - remainder, int(bit_string)]

	var hex_string := ""
	var i := 0
	while i < len(bit_string):
		hex_string += _BITS_TO_HEX.get(bit_string.substr(i, BITS_PER_HEX), "?")
		i += BITS_PER_HEX

	return hex_string


func hex_to_bits(hex_string: String) -> String:
	var bit_string := ""
	for character in hex_string:
		bit_string += _hex_to_bits.get(character, "?")

	return bit_string
