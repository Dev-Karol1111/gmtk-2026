extends CanvasLayer

@onready var player : AnimationPlayer = %player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.change_scene.connect(change_scene)
	hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_scene(path: String):
	show()
	player.play("fade")
	await player.animation_finished
	hide()
	get_tree().change_scene_to_file(path)
	await get_tree().create_timer(0.001).timeout
	player.play_backwards("fade")
	
