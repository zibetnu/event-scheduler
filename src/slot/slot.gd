extends PanelContainer


const SELECTED_COLOR := Color8(32, 255, 32, 255)
const UNSELECTED_COLOR := Color8(32, 32, 32, 255)

var _is_selected := false
var _value := 0

@onready var _rect := %ColorRect
@onready var _time_label := %TimeLabel
@onready var _value_label := %ValueLabel


func is_selected() -> bool:
	return _is_selected


func select(should_select: bool = true) -> void:
	_is_selected = should_select
	if should_select:
		_rect.set_color(SELECTED_COLOR)

	else:
		_rect.set_color(UNSELECTED_COLOR)


func set_time_label(new_text: String) -> void:
	_time_label.text = new_text


func set_value(new_value: int, max_value: int = -1) -> void:
	_value = new_value
	_value_label.text = str(_value)
	_value_label.set_visible(new_value != 0)

	var percentage: float
	if max_value > 0:
		percentage = float(new_value) / float(max_value)

	else:
		percentage = int(new_value != 0)

	var gradient_color := Color(
			UNSELECTED_COLOR.r + (SELECTED_COLOR.r - UNSELECTED_COLOR.r) * percentage,
			UNSELECTED_COLOR.g + (SELECTED_COLOR.g - UNSELECTED_COLOR.g) * percentage,
			UNSELECTED_COLOR.b + (SELECTED_COLOR.b - UNSELECTED_COLOR.b) * percentage,
			UNSELECTED_COLOR.a + (SELECTED_COLOR.a - UNSELECTED_COLOR.a) * percentage,
	)
	_rect.set_color(gradient_color)


func toggle() -> void:
	select(not _is_selected)
