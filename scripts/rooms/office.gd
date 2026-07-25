extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.office_agree.connect(func():  handle_choice(true))
	Signals.office_disagree.connect(func():  handle_choice(false))

func handle_choice(agree: bool):
	if agree:
		Management.take_damage(6)
	else:
		Management.take_damage(16)
	
	Management.switch_scene("res://scenes/rooms/hospital.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	Signals.start_dialog.emit(load("res://assets/dialogs/office.tres"))
