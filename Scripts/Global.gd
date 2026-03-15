extends Node

var score_player1: int = 0
var score_player2: int = 0
var p1_color: String = "red"
var p2_color: String = "blue"

var music_player: AudioStreamPlayer
var current_music: AudioStream = null

const MENU_MUSIC = preload("res://Assets/road_related/alexguz-food-coma-327598.mp3")

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

func play_shared_music(music: AudioStream) -> void:
	if current_music == music and music_player.playing:
		return
	
	current_music = music
	music_player.stream = music
	music_player.play()
	music_player.volume_db = -20

func stop_shared_music() -> void:
	if music_player.playing:
		music_player.stop()
	current_music = null
