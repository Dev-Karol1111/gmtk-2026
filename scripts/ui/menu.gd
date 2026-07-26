extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_btn_start_pressed() -> void:
	Management.start_game()

func _on_btn_option_pressed() -> void:
	$options.show() #show options menu

func _on_btn_quit_pressed() -> void:
	get_tree().quit() # quit game

func _on_btn_start_mouse_entered() -> void:
	$"hover audio2".play()

func _on_btn_option_mouse_entered() -> void:
	$"hover audio2".play()


func _on_btn_quit_mouse_entered() -> void:
	$"hover audio2".play()
