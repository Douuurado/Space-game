extends CharacterBody2D 

@onready var anim = $CollisionShape2D/AnimatedSprite2D

var player 
var speed = 100 
var follow_range = 500 
var attack_range = 150
var attack_cooldown = 0.5
var can_attack = true
var min_distance = 50

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if not player:
		return

	var dist = global_position.distance_to(player.global_position)

	if dist <= attack_range:
		velocity = Vector2.ZERO
		if can_attack:
			attack()

	elif dist < follow_range:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed

	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if anim:
		if velocity.length() > 0:
			anim.play("voando")
		#else:
			#anim.play("idle")

func attack():
	can_attack = false
	print("ATACOU")

	#if anim:
		#anim.play("attack")

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
