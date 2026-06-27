extends Node2D
class_name IntroScene

var time: float
@export var transition_player: AnimationPlayer
@export var newspaper: TextureRect

var tween: Tween

func _ready() -> void:
	transition_player.play("in")
	tween = create_tween()
	tween.tween_property(newspaper, "offset_transform_position", Vector2(0, 75), 2).set_trans(Tween.TRANS_QUART)
	tween.tween_callback(tween.kill)

func _physics_process(delta: float) -> void:
	time += delta
	if time >= 5:
		time = -9999
		transition_player.play("out")
		await transition_player.animation_finished
		get_tree().change_scene_to_file("res://main.tscn")
