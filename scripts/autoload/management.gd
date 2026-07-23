extends Node

var current_building := "starting"
var mode := "none"

var finished_dialogs : Dictionary[String, bool] = {
	"wake-up": false,
}
var ended_dialogs : Dictionary[String, bool] = {
	"wake-up": false,
}

func start_game() -> void:
	switch_scene("res://scenes/hospital.tscn")
	mode = "dialog"
	current_building = "hospital"

func switch_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
	Signals.start_dialog.emit(load("res://assets/dialogs/wake_up.tres"))
	await get_tree().create_timer(0.5).timeout
	Signals.start_dialog.emit(load("res://assets/dialogs/wake_up.tres"))

func _process(delta: float) -> void:
	check_dialogs()
	
func check_dialogs() -> void:
	if finished_dialogs["wake-up"] and !ended_dialogs["wake-up"]:
		mode = "free"
		