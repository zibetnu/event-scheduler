class_name ScheduleSerializer
extends Node


func can_unserialize(_schedule_string: String) -> bool:
	push_error("can_unserialize not implemented in %s" % name)
	return false


func get_title() -> String:
	push_error("get_title not implemented in %s" % name)
	return ""


func get_unserialize_requirements() -> String:
	push_error("get_unserialize_requirements not implemented in %s" % name)
	return ""


func serialize(_schedule_array: Array) -> String:
	push_error("serialize not implemented in %s" % name)
	return ""


func unserialize(_schedule_string: String) -> Array:
	push_error("unserialize not implemented in %s" % name)
	return []
