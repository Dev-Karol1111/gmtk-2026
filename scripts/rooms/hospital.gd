extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_body_entered(body: Node2D) -> void:
	Management.switch_scene("res://scenes/rooms/hallway.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void: # Old firend
	if !Management.finished_dialogs["old-friend-hallway"]:
		Signals.start_dialog.emit(load("res://assets/dialogs/old-friend-hallway.tres"))
