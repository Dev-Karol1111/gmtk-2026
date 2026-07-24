extends CanvasLayer

@onready var label : Label = $dialog/Label
@onready var buttons_container : HBoxContainer = $dialog/buttons
@onready var dialog : Node2D = $dialog

var current_dialog : DialogData
var current_node : DialogNode

func _ready() -> void:
	dialog.hide()
	show()
	Signals.start_dialog.connect(start_dialog)

func start_dialog(data: DialogData) -> void:
	Management.mode = "dialog"
	dialog.show()
	current_dialog = data
	show_block(current_dialog.starting_id)

func show_block(node_id: String) -> void:
	if node_id == "end":
		end_conversation()
		return
	current_node = current_dialog.get_node(node_id)
	if not current_node:
		end_conversation()
		return
	
	if current_node.end:
		end_conversation()
		
	label.text = current_node.text
	
	if current_node.signal_to_emit:
		Signals.emit_signal(current_node.signal_to_emit)
	
	for child in buttons_container.get_children():
		child.queue_free()
	
	for option in current_node.options:
		var next_id := current_node.options[option]
		var button = Button.new()
		button.text = option
		buttons_container.add_child(button)
		
		button.pressed.connect(func(): show_block(next_id))

func end_conversation():
	dialog.hide()
	Management.finished_dialogs.set(current_dialog.id, true)
	Management.mode = "free"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
