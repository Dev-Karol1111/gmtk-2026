extends CanvasLayer

@onready var label : Label = $Label
@onready var buttons_container : HBoxContainer = $buttons

var current_dialog : DialogData
var current_node : DialogNode

func _ready() -> void:
	hide()
	Signals.start_dialog.connect(start_dialog)

func start_dialog(data: DialogData) -> void:
	Management.mode = "dialog"
	show()
	current_dialog = data
	show_block(current_dialog.starting_id)

func show_block(node_id: String) -> void:
	if node_id == "end":
		hide()
		Management.finished_dialogs.set(current_dialog.id, true)
		Management.mode = "free"
		return
		
	current_node = current_dialog.get_node(node_id)
	if not current_node:
		return
		
	label.text = current_node.text
	
	for child in buttons_container.get_children():
		child.queue_free()
	
	for option in current_node.options:
		var next_id := current_node.options[option]
		var button = Button.new()
		button.text = option
		buttons_container.add_child(button)
		
		button.pressed.connect(func(): show_block(next_id))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
