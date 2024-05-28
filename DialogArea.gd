extends Area2D

var area_active = false

func _on_body_entered(_body):
	area_active = true
	Signalbus.emit_signal("can_hover", true)

func _on_body_exited(_body):
	area_active = false
	Signalbus.emit_signal("can_hover", false)	
