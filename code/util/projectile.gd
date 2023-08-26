extends DamageHitbox

@export var direction := Vector2.ZERO
@export var speed := 200.0
@export var lifetime := 10.0 # Seconds
@export var damage := 1
var life_timer

func _ready():
	life_timer = Timer.new()
	life_timer.connect("timeout", queue_free)

func move(delta):
	position += direction * delta * speed

func _physics_process(delta):
	move(delta)
