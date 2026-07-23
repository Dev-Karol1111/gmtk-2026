extends Node2D

@onready var sprite : Sprite2D = $sprite
@export var data : PickupData

func _ready() -> void:
	sprite.texture = data.sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if data.id == "phone":
		print("phone picked up")
	
