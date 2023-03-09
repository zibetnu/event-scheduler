extends Node2D


const MAX_RESULTS = 168

var _dragging := false
var _global_position_start := Vector2.ZERO
var _global_position_end := Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if _dragging and event is InputEventMouseMotion:
		_global_position_end = get_global_mouse_position()
		queue_redraw()
		return

	if event.is_action_pressed("mouse_select"):
		_dragging = true
		_global_position_start = event.global_position
		return

	if event.is_action_released("mouse_select"):
		_dragging = false
		_global_position_end = event.global_position
		_toggle_intersection()
		queue_redraw()


func _draw() -> void:
	if not _dragging:
		return

	var rect := Rect2(
			_global_position_start,
			_global_position_end - _global_position_start
	)

	draw_rect(rect, Color.WHITE, false)


func _toggle_intersection() -> void:
	for item in _intersect_shape():
		if item.collider.owner.has_method("toggle"):
			item.collider.owner.toggle()


func _intersect_shape() -> Array:
	var rect := RectangleShape2D.new()
	rect.extents = abs((_global_position_end - _global_position_start) / 2)

	var query := PhysicsShapeQueryParameters2D.new()
	query.set_shape(rect)
	query.transform = Transform2D(0, (_global_position_end + _global_position_start) / 2)

	var space_state := get_world_2d().direct_space_state
	return space_state.intersect_shape(query, MAX_RESULTS)
