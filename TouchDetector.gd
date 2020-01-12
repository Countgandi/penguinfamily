extends Node2D

signal screen_touch(position)
signal screen_swiped(position, direction)

onready var timer = $Timer
var swipe_start_position = Vector2()

func _input(event):
	if not event is InputEventScreenTouch:
		return
	if event.pressed:
		_start_detection(event.position)
	else:
		_end_detection(event.position)

func _start_detection(position):
	swipe_start_position = position
	timer.start()
	
func _end_detection(position):
	if not timer.is_stopped():
		emit_signal("screen_touch", position)
		timer.stop()
		return
	timer.stop()
	var direction = (position - swipe_start_position).normalized()
	emit_signal("screen_swiped", position, Vector2(-sign(direction.x), -sign(direction.y)))


