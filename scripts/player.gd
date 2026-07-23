extends CharacterBody2D

@export var speed := 100.0

@onready var camera : Camera2D = $Camera2D

func _process(delta: float) -> void:
	if Management.mode == "dialog":
		camera.zoom = Vector2(6,6)
	else:
		camera.zoom = Vector2(6,6)

func _physics_process(delta: float) -> void:
	if Management.mode == "dialog": return
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				$AnimatedSprite2D.play("moving_east")
			else:
				$AnimatedSprite2D.play("moving_weast")
		else:
			if direction.y > 0:
				$AnimatedSprite2D.play("moving_south")
			else:
				$AnimatedSprite2D.play("moving_north")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		$AnimatedSprite2D.play("idle") 
	
	move_and_slide()


func _on_bedroom_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/rooms/bedroom.tscn")


func _on_exit_body_entered(body: Node2D) -> void:
	Management.switch_scene("res://scenes/hallway.tscn")
