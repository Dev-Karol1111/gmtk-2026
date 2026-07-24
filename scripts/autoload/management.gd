extends Node

var current_building := "starting"
var mode := "none"

var finished_dialogs : Dictionary[String, bool] = {
	"wake-up": false,
	"old-friend-hallway" : false,
}

var time_remain := 24

func _ready() -> void:
	Signals.old_firend_agree.connect(old_firend_agreed)
	Signals.take_damage.connect(take_damage)

func start_game() -> void:
	switch_scene("res://scenes/rooms/hospital.tscn")
	await get_tree().create_timer(0.5).timeout
	Signals.start_dialog.emit(load("res://assets/dialogs/wake_up.tres"))
	current_building = "hospital"

func switch_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)

func take_damage(damage: int):
	time_remain -= damage

func _process(delta: float) -> void:
	check_dialogs()
	
func check_dialogs() -> void:
	pass

func old_firend_agreed():
	Signals.take_damage.emit(2)