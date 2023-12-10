extends Area2D

func send_event():
	Signals.emit_signal("boostJump", 2)
