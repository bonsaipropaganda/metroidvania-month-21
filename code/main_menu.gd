extends Sprite2D
@onready var main = preload("res://scenes/state_machine/main.tscn")

func _ready():
	MusicManager.menu.play()

func _on_play_pressed():
	MusicManager.menu.stop()
	get_tree().change_scene_to_packed(main)

func _on_credits_pressed():
	$Camera2D.position.x = 1280 / 2

func _on_quit_pressed():
	get_tree().quit()


func _on_go_back_pressed():
	$Camera2D.position.x = 0
