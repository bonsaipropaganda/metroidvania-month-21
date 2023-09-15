extends Node2D

@onready var menu = $Menu
@onready var music = $Music



func _on_music_finished():
	await get_tree().create_timer(30).timeout
	music.play()
