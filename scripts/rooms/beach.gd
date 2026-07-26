extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.sandcastle_agree.connect(func(): handle_choice(true))
	Signals.sandcastle_disagree.connect(func(): handle_choice(false))

func handle_choice(agree : bool):
	if agree:
		Management.take_damage(2)
	Signals.task_finished.emit("swimming-with-shark")
	Signals.start_cutsene.emit(load("res://assets/cutscenes/swim-with-sharks.tres"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	Signals.start_dialog.emit(load("res://assets/dialogs/sand_castle.tres"))
