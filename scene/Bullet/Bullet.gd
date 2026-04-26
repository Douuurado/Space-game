extends Node

var mass = 0 #pegar no bullet type mass do objeto
var speed = 0 #pegar no bullet type speed do objeto
var bullet_position = 1 #muda de acordo com a bala
var player_radius = 25 #fixo, pode mudar
var armor_points = 0 #max 1000, pegar do objeto
var entity_position = 0 #pegar de um objeto
var entity_health = 0 #pegar de um objeto
var armor_toughness = 0 #max 100
var protection_enchantment = 0 #max 5
enum Bullets_Types_Mass {
 magic = 1,
 caliber12 = 36,
 mm20 = 100,
 magnum367 = 11,
 remington223 = 4,
 arrow = 30,
 bmg50 = 48,
 punch = 20, 
 mm9 =  8,
 winchester243 = 7,
}
enum Bullets_Types_Speed {
 mm9 = 120,
 remington223 = 320,
 mm20 = 350,
 caliber12 = 160,
 magnum367 = 180,
 arrow = 50,
 bmg50 = 350,
 remington243 = 320,
 punch = 11,
 magic = 50
}



func get_bullet_type_mass(): #pegar tipo de bala de uma arma em outro script para saber massa
	pass

func get_bullet_type_speed(): #pegar tipo de bala de uma arma em outro script para saber velocidade
	pass



@warning_ignore("shadowed_variable")
func bullet_visual_speed(speed): #velocidade da bala que vai ser projetada na tela
	@warning_ignore("unused_variable")
	var visual_speed = speed / 10

func delete_shoot(): #deleta o tiro
	pass

#Kinematics / damage supressions
@warning_ignore("shadowed_variable")
func shoot_damage(mass, speed): #dano da bala sem supressão de dano
	@warning_ignore("unused_variable")
	var force = mass * speed #a cada 40, +1 damage
	@warning_ignore("unused_variable")
	var shoot_damage = force / 40
	return shoot_damage
	
func damage_supression(): #dano com a supressão vinda dos pontos de armadura
	var damage_supression = shoot_damage * ((armor_points / 12.5) / 100)
	var damage_supression1 = shoot_damage - damage_supression
	var total_damage_supression = damage_supression1 / armor_toughness
	return total_damage_supression
	
func enchantments_damage_supression():
	var total_damage_supression
	total_damage_supression = total_damage_supression / (protection_enchantment * 2)
	return total_damage_supression





func _input(event): #criar tiro e continuar até deletar/acertar alvo
	if event.is_action_pressed("Bullet_shoot"):
		if event is InputEventMouseButton:
			var mouse_position = event.position
			print(mouse_position)
		#criação da bullet em direção a posição do mouse na tela
		var total_damage_supression
		var shoot_in_range = true
		
		
		while shoot_in_range == true:
			await get_tree().create_timer(1.0).timeout
			speed -= 1
			if speed == 0 or bullet_position > player_radius:
				delete_shoot()
				shoot_in_range = false
				break
			else:
				break
			if entity_position == bullet_position:
				entity_health = entity_health - total_damage_supression
			else:
				break
		
		pass





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
	
