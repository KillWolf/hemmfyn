extends Area2D

@export var area_name: String = ""

func _on_body_entered(_body):
	$"../Object".toggle_hover(true)
	#Signalbus.emit_signal("can_hover", true, area_name)
#
func _on_body_exited(_body):
	$"../Object".toggle_hover(false)

	#Signalbus.emit_signal("can_hover", false, area_name)
