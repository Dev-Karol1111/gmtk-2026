extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Management.current_building = "hallway"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_body_entered(body: Node2D) -> void:
	Management.switch_scene("res://scenes/rooms/hospital.tscn")


func _on_oldfriend_body_entered(body: Node2D) -> void:
	Signals.start_dialog.emit(load("res://assets/dialogs/old-friend-hallway.tres"))
	