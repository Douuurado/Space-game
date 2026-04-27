extends CharacterBody2D

const SPEED = 300.0
var delta_1 = 0.0
@onready var weapon = $Weapon

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if direction != Vector2.ZERO:		
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_pressed("Bullet_shoot"):
		weapon.shoot()
