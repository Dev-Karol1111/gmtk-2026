extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("new_animation")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!$AnimationPlayer.is_playing()):
		get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")
	pass
