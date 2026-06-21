@tool
extends Node2D
class_name Segment

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var segmentData: WheelSegment:
	set(new_value):
		segmentData = new_value
		if segmentData and sprite_2d:
			sprite_2d.texture = segmentData.texture

func _ready() -> void:
	if segmentData and sprite_2d:
		sprite_2d.texture = segmentData.texture
