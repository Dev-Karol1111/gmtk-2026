extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.kitten_agree.connect(func(): kitten_choice(true))
	Signals.kitten_disagree.connect(func(): kitten_choice(false))

func kitten_choice(agreed: bool):
	if agreed:
		Management.take_damage(1)
	Signals.task_finished.emit("sky-diving")
	Signals.start_cutsene.emit(load("res://assets/cutscenes/sky-diving.tres"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !Management.finished_dialogs["kitten"]:
		Signals.start_dialog.emit(load("res://assets/dialogs/kitten.tres"))