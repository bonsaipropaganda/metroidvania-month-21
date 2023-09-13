extends Area2D


# node refs
@onready var e_indicator = $"../EIndicator"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("player"):
		e_indicator.visible = true


func _on_body_exited(body):
	if body.is_in_group("player"):
		e_indicator.visible = false
