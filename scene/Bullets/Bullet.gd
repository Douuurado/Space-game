extends Node2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 1000.0
var max_distance: float = 700.0
var damage: int = 10
var caliber: String = ""


var start_position: Vector2

func _ready():
	start_position = global_position
	
func _process(delta):
	global_position += direction * speed * delta

	if global_position.distance_to(start_position) >= max_distance:
		queue_free()
