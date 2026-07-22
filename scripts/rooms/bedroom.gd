extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Management.current_building = "bedroom"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_entryexit_body_entered(body: Node2D) -> void:
	if Management.current_building == "bedroom":
		Management.current_building = "map"
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
