extends Node2D

var previous_time : int

@onready var image : AnimatedSprite2D = $AnimatedSprite2D
@onready var label : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	previous_time = Management.time_remain
	
func _process(delta: float) -> void:
	if Management.time_remain != previous_time:
		label.text = "%s Hours" % [Management.time_remain]
		adjust_image()
	
func adjust_image():
	if Management.time_remain == 24: image.play("24")
	elif Management.time_remain >= 20: image.play("20")
	elif Management.time_remain >= 16: image.play("16")
	elif Management.time_remain >= 12: image.play("12")
	elif Management.time_remain >= 8: image.play("8")
	else: image.play("4")
	
