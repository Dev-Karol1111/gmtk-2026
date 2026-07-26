extends CanvasLayer

@onready var label_first : Label = $dialog/label_first
@onready var label_second : Label = $dialog/label_second
@onready var buttons_container_first : HBoxContainer = $dialog/buttons_first
@onready var buttons_container_second : HBoxContainer = $dialog/buttons_second
@onready var bg_first : Sprite2D = $dialog/first_bg
@onready var bg_second : Sprite2D = $dialog/second_bg
@onready var first_person : Sprite2D = $dialog/first_person
@onready var second_person : Sprite2D = $dialog/second_person
@onready var dialog : Node2D = $dialog
@onready var taking_damage_animation : Node2D = $taking_damage
@onready var dying_animation : Node2D = $dying_animation

var current_dialog : DialogData
var current_node : DialogNode

func _ready() -> void:
	dialog.hide()
	show()
	Signals.start_dialog.connect(start_dialog)
	Signals.taking_damage_animation.connect(show_taking_damage_animation)
	Signals.dying_animation.connect(death)

func death():
	dying_animation.show()
	await get_tree().create_timer(3).timeout
	# TODO: Add end screen

func show_taking_damage_animation():
	taking_damage_animation.show()
	await get_tree().create_timer(3).timeout
	taking_damage_animation.hide()
	
func start_dialog(data: DialogData) -> void:
	Management.mode = "dialog"
	dialog.show()
	current_dialog = data
	show_block(current_dialog.starting_id)
	first_person.texture = data.first_person
	second_person.texture = data.second_person

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
	
	var label : Label
	var buttons_container : HBoxContainer
	
	if current_node.person == "first-person":
		bg_second.hide()
		buttons_container_second.hide()
		label_second.hide()
		second_person.hide()
		first_person.show()
		bg_first.show()
		buttons_container_first.show()
		label_first.show()
		label = label_first
		buttons_container = buttons_container_first
	else:
		bg_first.hide()
		buttons_container_first.hide()
		label_first.hide()
		first_person.hide()
		second_person.show()
		bg_second.show()
		buttons_container_second.show()
		label_second.show()
		label = label_second
		buttons_container = buttons_container_second
	
	#label.text = current_node.text
	
	if current_node.signal_to_emit:
		Signals.emit_signal(current_node.signal_to_emit)
	
	for child in buttons_container.get_children():
		child.queue_free()
	
	await show_text(label, current_node.text)
		
	for option in current_node.options:
		var next_id := current_node.options[option]
		var button := Button.new()
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

func show_text(label: Label, text : String):
	const speed = 30.0
	label.text = text
	label.visible_ratio = 0.0
	var duration = text.length() / speed
	var tween = create_tween()
	tween.tween_property(label,  "visible_ratio", 1.0, duration)
	
	await tween.finished
	
	