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
					if music_player.stream.get_sync_stream_volume(4) != -60: music_player.stream.set_sync_stream_volume(4, -60)
					if music_player.stream.get_sync_stream_volume(3) != -60: music_player.stream.set_sync_stream_volume(3, -60)
				else:
					if music_player.stream.get_sync_stream_volume(4) != -60: music_player.stream.set_sync_stream_volume(4, -60)
					if music_player.stream.get_sync_stream_volume(3) != 0: music_player.stream.set_sync_stream_volume(3, 0)
			else:
				if music_player.stream.get_sync_stream_volume(4) != 1: music_player.stream.set_sync_stream_volume(4, 1)
				if music_player.stream.get_sync_stream_volume(3) != 0: music_player.stream.set_sync_stream_volume(3, 0)
		elif scene is MainMenu:
			if music_player.stream.get_sync_stream_volume(4) != -60: music_player.stream.set_sync_stream_volume(4, -60)
			if music_player.stream.get_sync_stream_volume(3) != -60: music_player.stream.set_sync_stream_volume(3, -60)
		else:
			if music_player.stream.get_sync_stream_volume(4) != 1: music_player.stream.set_sync_stream_volume(4, 1)
			if music_player.stream.get_sync_stream_volume(3) != 0: music_player.stream.set_sync_stream_volume(3, 0)

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
