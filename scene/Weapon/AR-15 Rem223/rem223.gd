extends Node2D

@export var bullet_scene: PackedScene

@export var caliber: String = "remington223"
@export var bullet_speed: float = 1500
@export var bullet_range: float = 1000
@export var bullet_damage: int = 28
@export var fire_rate: float = 0.09
@export var pellet_count: int = 1
@export var spread: float = 0.015

@onready var muzzle = $Muzzle

var can_shoot: bool = true

@warning_ignore("unused_parameter")
func _process(delta):
	var mouse_pos = get_global_mouse_position()

	look_at(mouse_pos)

	if mouse_pos.x < global_position.x:
		scale.y = -1
	else:
		scale.y = 1

func shoot():
	if bullet_scene == null:
		return
		
	if can_shoot == false:
		return
	
	can_shoot = false

	for i in range(pellet_count):
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)

		bullet.global_position = muzzle.global_position

		var dir = (get_global_mouse_position() - muzzle.global_position).normalized()
		dir = dir.rotated(randf_range(-spread, spread))

		bullet.direction = dir
		bullet.speed = bullet_speed
		bullet.max_distance = bullet_range
		bullet.damage = bullet_damage
		bullet.caliber = caliber

	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true
