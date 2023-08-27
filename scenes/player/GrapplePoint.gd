extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var p = Global.get_player()
	if p:
		set_point_position(1, p.global_position - global_position)
