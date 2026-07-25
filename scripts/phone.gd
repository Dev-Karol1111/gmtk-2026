extends CanvasLayer

@onready var options_container : VBoxContainer = $VBoxContainer

@export var options : Array[String] = [
	"Go sky diving", "Food eating contest", "Go to work", "Swimming with sharks"
]

var generated_data := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func first_run() -> void:
	if not generated_data:
		var options2 := options.duplicate()
		options2.shuffle()
		var to_display := options2.slice(0,4)
		
		for o in to_display:
			var button = Button.new()
			button.text = o
			button.pressed.connect(check_option.bind(button.text))
			options_container.add_child(button)
		
		generated_data = true
	show()
	
func check_option(option: String):
	if option == options[0]: #Sky diving
		Management.switch_scene("res://scenes/rooms/airplane.tscn")
	elif option == options[3]: # Swiming with sharks
		Management.switch_scene("res://scenes/rooms/beach.tscn")
	elif option == options[1]: # Food eating contest
		Signals.start_cutsene.emit(load("res://assets/cutscenes/food_eating_contest_thumbnail.tres"))
	elif option == options[2]: # Go to work
		Management.switch_scene("res://scenes/rooms/office.tscn")
	
		
