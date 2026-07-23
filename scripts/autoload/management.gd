extends Node

var current_building := "starting"
var mode := "none"

func start_game() -> void:
	switch_scene("res://scenes/hospital.tscn")
	mode = "dialog"

func switch_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
	Signals.start_dialog.emit(load("res://assets/dialogs/wake_up.tres"))