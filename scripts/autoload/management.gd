extends Node

var current_building := "starting"
var mode := "none"

var finished_dialogs : Dictionary[String, bool] = {
	"wake-up": false,
	"old-friend-hallway" : false,
	"kitten" : false,
}

var finished_tasks : Dictionary[String, bool] = {
	"sky-diving" : false,
	"swimming-with-shark" : false,
	"food-contest" : false,
	"office" : false,
}

var time_remain := 24
func _ready() -> void:
	for t in finished_tasks.keys():
		finished_tasks[t] = false
	for d in finished_dialogs.keys():
		finished_dialogs[d] = false
	
	mode = "dialog"
	
	Signals.old_firend_agree.connect(old_firend_agreed)
	Signals.take_damage.connect(take_damage)
	Signals.start_cutsene.connect(start_cutscene)
	Signals.task_finished.connect(check_tasks)

func start_game() -> void:
	await get_tree().create_timer(0.005).timeout
	switch_scene("res://scenes/rooms/hospital.tscn")
	await get_tree().create_timer(2.5).timeout
	Signals.start_dialog.emit(load("res://assets/dialogs/wake_up.tres"))
	current_building = "hospital"

func switch_scene(path: String) -> void:
	#get_tree().change_scene_to_file(path)
	#Signals.change_scene.emit(path)
	var fade_animation = load("res://scenes/canvas_layer.tscn")
	var fade_i = fade_animation.instantiate()
	var player: AnimationPlayer = fade_i.get_node("player")
	get_tree().root.add_child(fade_i)
	fade_i.show()
	player.play("fade")
	await player.animation_finished
	
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	fade_i.queue_free()
	
	await get_tree().create_timer(0.01).timeout
	
	fade_i = fade_animation.instantiate()	
	get_tree().root.add_child(fade_i)
	player = fade_i.get_node("player")
	player.play_backwards("fade")
	await player.animation_finished
	fade_i.queue_free()

func switch_scene_node(node: Node) -> void:
	#get_tree().change_scene_to_file(path)
	#Signals.change_scene.emit(path)
	var fade_animation = load("res://scenes/canvas_layer.tscn")
	var fade_i = fade_animation.instantiate()
	var player: AnimationPlayer = fade_i.get_node("player")
	get_tree().root.add_child(fade_i)
	fade_i.show()
	player.play("fade")
	await player.animation_finished
	
	get_tree().change_scene_to_node(node)
	await get_tree().process_frame
	fade_i.queue_free()
	
	await get_tree().create_timer(0.01).timeout
	
	fade_i = fade_animation.instantiate()	
	get_tree().root.add_child(fade_i)
	player = fade_i.get_node("player")
	player.play_backwards("fade")
	await player.animation_finished
	fade_i.queue_free()

func switch_scene_packed(node: PackedScene) -> void:
	#get_tree().change_scene_to_file(path)
	#Signals.change_scene.emit(path)
	var fade_animation = load("res://scenes/canvas_layer.tscn")
	var fade_i = fade_animation.instantiate()
	var player: AnimationPlayer = fade_i.get_node("player")
	get_tree().root.add_child(fade_i)
	fade_i.show()
	player.play("fade")
	await player.animation_finished
	
	get_tree().change_scene_to_packed(node)
	await get_tree().process_frame
	fade_i.queue_free()
	
	await get_tree().create_timer(0.01).timeout
	
	fade_i = fade_animation.instantiate()	
	get_tree().root.add_child(fade_i)
	player = fade_i.get_node("player")
	player.play_backwards("fade")
	await player.animation_finished
	fade_i.queue_free()


func take_damage(damage: int):
	time_remain -= damage
	if time_remain <= 0:
		Signals.dying_animation.emit()
	else:
		Signals.taking_damage_animation.emit()

func _process(delta: float) -> void:
	check_dialogs()
	
func check_dialogs() -> void:
	pass

func old_firend_agreed():
	Signals.take_damage.emit(2)

func start_cutscene(data: CutsceneData):
	var scene = load("res://scenes/cutscene.tscn")
	scene = scene.instantiate()
	scene.data = data
	switch_scene_node(scene)
	await get_tree().create_timer(data.duration+1.01).timeout
	switch_scene_packed(data.returning_scene)

func check_tasks(task_name: String) -> void:
	await get_tree().create_timer(6).timeout
	finished_tasks[task_name] = true
	for i in finished_tasks.values():
		if not i:
			return
	
	await get_tree().create_timer(2).timeout
	switch_scene("res://scenes/ending.tscn")
