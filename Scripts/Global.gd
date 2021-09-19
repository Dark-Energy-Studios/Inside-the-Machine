extends Node

var employee_warnings = 0
var current_level: int
var meeting_voice_lines_order: Array

# Returns the new index and removes it from the Array.
# Returns null if the Array is empty
func get_next_meeting_voice_line():
	if len(meeting_voice_lines_order) == 0:
		return null

	var new_index: int = meeting_voice_lines_order[0]
	meeting_voice_lines_order.pop_front()
	return new_index
