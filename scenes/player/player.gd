extends CharacterBody2D

signal laser_shooted(pos, direction)
signal grande_thrown(pos, direction)

const SPEED = 500

var can_laser: bool = true
var can_granade: bool = true

func _process(delta):
	var direction = Input.get_vector("left","right","up","down")	
	velocity = direction * 50000 * delta
	
	# rotate
	
	look_at(get_global_mouse_position())

	#laser shooting input
	if Input.is_action_just_pressed("primary action") and can_laser:
		# randomly select a marker2d for laser to start
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserTimer.start()
		var pos = selected_laser.global_position
		var player_direction =(get_global_mouse_position() - position).normalized()
		laser_shooted.emit(pos, player_direction)
	
	if Input.is_action_just_pressed("secondary action") and can_granade:
		print("boom")
		var grenade_markers = $GrenadeStartPositions.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]
		can_granade = false
		$GrandeTimer.start()
		var pos = selected_grenade.global_position
		var player_direction =(get_global_mouse_position() - position).normalized()
		grande_thrown.emit(pos, player_direction)
	
	move_and_slide()

func _on_laser_timer_timeout():
	can_laser = true


func _on_grande_timer_timeout():
	can_granade = true
