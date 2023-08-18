extends Area2D

var BalloonScene = preload("res://scenes/balloon.tscn")
@export var dialog_resource: DialogueResource
@export var dialog_start: String = "start"


func action():
	var balloon = BalloonScene.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialog_resource, dialog_start)
