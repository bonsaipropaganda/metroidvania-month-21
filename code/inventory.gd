extends Control

signal opened
signal closed

var is_open: bool = false

func open():
	is_open = true
	visible = true
	opened.emit()

func close():
	is_open = false
	visible = false
	closed.emit()

func _ready():
	close()
