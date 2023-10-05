extends Node2D

var laser_scene : PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body):
	print("Player has entered the gate" + body.name)


func _on_player_grande_thrown(pos, dir):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	$Projectiles.add_child(grenade)
	


func _on_player_laser_shooted(pos, dir):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	# change the laser rotation to match the player vector2
	laser.rotation_degrees =rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	

	$Projectiles.add_child(laser)


	print("Laser shooted from level")
