extends Resource
class_name DialogData

@export var id : String = ""
@export var starting_id : String = ""
@export var nodes : Array[DialogNode] = []
@export var first_person : Texture2D
@export var second_person : Texture2D

func get_node(searching_id : String) -> DialogNode:
	for node in nodes:
		if node.id == searching_id:
			return node
	return null
	