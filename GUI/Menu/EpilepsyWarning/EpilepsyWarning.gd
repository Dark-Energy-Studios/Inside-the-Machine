extends Control

signal approved()

func _on_MainWarning_accepted():
	$MainWarning.visible = false
	$ApproveWarning.visible = true


func _on_ApproveWarning_approved():
	emit_signal("approved")	
