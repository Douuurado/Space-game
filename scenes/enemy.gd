extends CharacterBody2D

@onready var anim = $CollisionShape2D/anim

var player
var speed = 100
var follow_range = 500
var min_distance = 20
var attack_range = 100
var attack_cooldown = 1.0
var can_attack = true

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if not player:
		return

	var dist = global_position.distance_to(player.global_position)

	if dist <= attack_range:
		velocity = Vector2.ZERO
		if can_attack:
			attack()

	elif dist < follow_range and dist > min_distance:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed

	else:
		velocity = Vector2.ZERO
	move_and_slide()
func attack(): 
	can_attack = false
	
	print("ATACOU")
	
	if anim:
		anim.play("voando")

	await get_tree().create_timer(attack_cooldown).timeout
	
	can_attack = true
