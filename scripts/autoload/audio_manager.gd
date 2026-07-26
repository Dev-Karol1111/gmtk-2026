extends Node

var audio_player : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.bus = "music"

func play_music():
	var stream = load("res://assets/audio/main audio.mp3")
	stream.loop = true
	audio_player.stream = stream
	audio_player.play()

func stop():
	audio_player.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
