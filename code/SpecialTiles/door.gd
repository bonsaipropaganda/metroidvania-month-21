extends StaticBody2D

signal state_changed

enum state{opened,closed}
@export var current_state: state:
	set(value):
		current_state = value
		state_changed.emit()

# node refs
@onready var wall_sprite = $Wall
@onready var col_shape = $CollisionShape2D

func _ready():
	state_changed.connect(_on_state_changed)
	_on_state_changed()

func _on_state_changed():
	if current_state == state.opened:
		wall_sprite.visible = false
		col_shape.set_deferred("disabled",true)
	else: 
		wall_sprite.visible = true
		col_shape.set_deferred("disabled",false)
