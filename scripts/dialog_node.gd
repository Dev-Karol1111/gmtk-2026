class_name DialogNode
extends Resource

@export var id: String = ""
@export_multiline var text : String = ""
@export var signal_to_emit : String = ""
@export var end : bool = false
@export_enum("first-person", "second-person") var person : String

@export var options : Dictionary[String, String] = {}
