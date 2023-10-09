extends Node

@export var Rifleman = "res://rifleman.tscn"
@export var MissleLauncher = "res://missle_launcher.tscn"
@export var Tank = "res://tank.tscn"

func _process(_delta):
	if Input.is_action_just_pressed("Spawn_Rifleman"):
		spawn_unit(Rifleman)
	elif Input.is_action_just_pressed("Spawn_MissleLauncher"):
		spawn_unit(MissleLauncher)
	elif Input.is_action_just_pressed("Spawn_Tank"):
		spawn_unit(Tank)

func spawn_unit(Unit : String):
	var mouse_position = get_viewport().get_mouse_position()
	var unit = load(Unit).instantiate()
	unit.global_position = mouse_position
	add_child(unit)
