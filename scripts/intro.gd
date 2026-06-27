extends Node2D

var time: float

func _physics_process(delta: float) -> void:
	time += delta
	if time >= 5:
		pass
