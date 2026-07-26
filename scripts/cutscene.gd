extends Node2D

var data : CutsceneData

@onready var image : Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data.office:
		$Camera2D.zoom = Vector2(.65, .65)
		$VideoStreamPlayer.show()
	else:
		image.texture = data.image


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
