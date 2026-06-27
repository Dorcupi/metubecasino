extends Node

var highest_score: float = 0
var highest_time: float = 0

var current_score: float
var current_time: float

var beat_game: bool = false
var beat_pb: bool = false
var times_played: int = 0

const MUSIC = preload("res://resources/music.tres")

var music_player: AudioStreamPlayer

var fixing_audio: bool = false
var tween: Tween

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.stream = MUSIC
	music_player.volume_db = -15
	music_player.bus = "Music"
	add_child(music_player)
	music_player.play()

func _physics_process(delta: float) -> void:
	if music_player:
		var scene: Node = get_tree().current_scene
		if scene is Game:
			var game: Game = get_tree().current_scene
			if game.game_state == game.GAME_STATE.GAMBLING:
				if game.in_negatives:
					if music_player.stream.get_sync_stream_volume(4) != -60 or music_player.stream.get_sync_stream_volume(3) != -60:
						if not fixing_audio:
							fixing_audio = true
							if tween: tween.kill()
							tween = create_tween()
							tween.tween_method(update_stream_volume.bind(4), music_player.stream.get_sync_stream_volume(4), -60, 4).set_trans(Tween.TRANS_EXPO)
							tween.parallel().tween_method(update_stream_volume.bind(3), music_player.stream.get_sync_stream_volume(3), -60, 4).set_trans(Tween.TRANS_EXPO)
							tween.tween_callback(func ():
								tween.kill()
								fixing_audio = false)
				else:
					if music_player.stream.get_sync_stream_volume(4) != -60 or music_player.stream.get_sync_stream_volume(3) != 0:
						if not fixing_audio:
							fixing_audio = true
							if tween: tween.kill()
							tween = create_tween()
							tween.tween_method(update_stream_volume.bind(4), music_player.stream.get_sync_stream_volume(4), -60, 4).set_trans(Tween.TRANS_EXPO)
							tween.parallel().tween_method(update_stream_volume.bind(3), music_player.stream.get_sync_stream_volume(3), 0, 2).set_trans(Tween.TRANS_EXPO)
							tween.tween_callback(func ():
								tween.kill()
								fixing_audio = false)
			else:
				if music_player.stream.get_sync_stream_volume(4) != 1 or music_player.stream.get_sync_stream_volume(3) != 0:
					if not fixing_audio:
						fixing_audio = true
						if tween: tween.kill()
						tween = create_tween()
						tween.tween_method(update_stream_volume.bind(4), music_player.stream.get_sync_stream_volume(4), 1, 2).set_trans(Tween.TRANS_EXPO)
						tween.parallel().tween_method(update_stream_volume.bind(3), music_player.stream.get_sync_stream_volume(3), 0, 2).set_trans(Tween.TRANS_EXPO)
						tween.tween_callback(func ():
							tween.kill()
							fixing_audio = false)
		elif scene is MainMenu or scene is IntroScene:
			if music_player.stream.get_sync_stream_volume(4) != -60 or music_player.stream.get_sync_stream_volume(3) != -60:
				if not fixing_audio:
					fixing_audio = true
					if tween: tween.kill()
					tween = create_tween()
					tween.tween_method(update_stream_volume.bind(4), music_player.stream.get_sync_stream_volume(4), -60, 4).set_trans(Tween.TRANS_EXPO)
					tween.parallel().tween_method(update_stream_volume.bind(3), music_player.stream.get_sync_stream_volume(3), -60, 4).set_trans(Tween.TRANS_EXPO)
					tween.tween_callback(func ():
						tween.kill()
						fixing_audio = false)
		elif scene is EndScreen:
			if beat_game:
				if music_player.stream.get_sync_stream_volume(4) != 1 or music_player.stream.get_sync_stream_volume(3) != 0:
					if not fixing_audio:
						fixing_audio = true
						if tween: tween.kill()
						tween = create_tween()
						tween.tween_method(update_stream_volume.bind(4), music_player.stream.get_sync_stream_volume(4), 1, 2).set_trans(Tween.TRANS_EXPO)
						tween.parallel().tween_method(update_stream_volume.bind(3), music_player.stream.get_sync_stream_volume(3), 0, 2).set_trans(Tween.TRANS_EXPO)
						tween.tween_callback(func ():
							tween.kill()
							fixing_audio = false)
			else:
				if music_player.stream.get_sync_stream_volume(4) != -60 or music_player.stream.get_sync_stream_volume(3) != -60:
					if not fixing_audio:
						fixing_audio = true
						if tween: tween.kill()
						tween = create_tween()
						tween.tween_method(update_stream_volume.bind(4), music_player.stream.get_sync_stream_volume(4), -60, 4).set_trans(Tween.TRANS_EXPO)
						tween.parallel().tween_method(update_stream_volume.bind(3), music_player.stream.get_sync_stream_volume(3), -60, 4).set_trans(Tween.TRANS_EXPO)
						tween.tween_callback(func ():
							tween.kill()
							fixing_audio = false)
		else:
			if music_player.stream.get_sync_stream_volume(4) != 1 or music_player.stream.get_sync_stream_volume(3) != 0:
				if not fixing_audio:
					fixing_audio = true
					if tween: tween.kill()
					tween = create_tween()
					tween.tween_method(update_stream_volume.bind(4), music_player.stream.get_sync_stream_volume(4), 1, 2).set_trans(Tween.TRANS_EXPO)
					tween.parallel().tween_method(update_stream_volume.bind(3), music_player.stream.get_sync_stream_volume(3), 0, 2).set_trans(Tween.TRANS_EXPO)
					tween.tween_callback(func ():
						tween.kill()
						fixing_audio = false)

func update_stream_volume(volume: float, stream: int) -> void:
	music_player.stream.set_sync_stream_volume(stream, volume)

func update_score(score: float, time: float, won: bool) -> void:
	current_score = score
	current_time = time
	beat_pb = false
	beat_game = won
	times_played += 1
	if score > highest_score:
		highest_score = score
		highest_time = time
		beat_pb = true
	elif score == highest_score and time < highest_time:
		highest_score = score
		highest_time = time
		beat_pb = true
