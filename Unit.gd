extends CharacterBody2D

@onready var search_box = $SearchBox
@export var Projectile : PackedScene
@onready var weapon_timer = $WeaponCooldown

@export var health = 100
@export var weapon_damage = 10
@export var weapon_cooldown = 0.2

var targets = []
var playerid

func _ready():
	weapon_timer.wait_time = weapon_cooldown

func _process(_delta):
	if weapon_timer.time_left == 0:
		weapon_timer.start()

func _on_search_box_body_entered(body):
	if(body != self):
		targets.append(body)

func shoot_at_targets():
	if targets.size() > 0:
		for target in targets:
			if not target:
				targets.erase(target)
				return
		var projectile = Projectile.instantiate()
		projectile.global_position = global_position
		projectile.target = find_lowest_health_target()
		projectile.damage = weapon_damage
		var root = get_parent()
		root.add_child(projectile)
#		call_deferred("add_child", projectile)

func find_lowest_health_target():
	var lowest = targets[0]
	if targets.size() == 1:
		return targets[0]
	for target in targets:
		if target.health < lowest.health:
			lowest = target
	return lowest

func deal_damage(damage):
	health = clampi(health - damage, 0, health)
	if health == 0:
		queue_free()

func _on_weapon_cooldown_timeout():
	shoot_at_targets()
