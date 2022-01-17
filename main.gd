extends TileMap

var last_pos := Vector2(80,60)
var last_mouse: Vector2


func _physics_process(delta: float) -> void:
	set_movedir(get_movedir())
	if Input.is_mouse_button_pressed(1):
		if get_movedir():
			last_mouse = Input.get_last_mouse_speed()
		else:
			if last_mouse != Input.get_last_mouse_speed():
				if last_mouse.x - Input.get_last_mouse_speed().x > 500 or last_mouse.y - Input.get_last_mouse_speed().y > 500:
					last_mouse = Input.get_last_mouse_speed()
					for x in 161:
						for y in 121:
							set_cellv(Vector2(x,y),2)

func set_movedir(movedir):
	if movedir != Vector2.ZERO:
		$"../rl".rotation_degrees += movedir.x/2
		$"../ud".rotation_degrees += movedir.y/2
		set_cellv(last_pos, 0)
		last_pos += movedir/2
		last_pos = Vector2(clamp(last_pos.x,0, 160),clamp(last_pos.y, 0, 120)) 
		set_cellv(last_pos, 1)


func get_movedir():
	var UP_h      := Input.is_action_pressed("ui_up.5")
	var DOWN_h    := Input.is_action_pressed("ui_down.5")
	var LEFT_h    := Input.is_action_pressed("ui_left.5" )
	var RIGHT_h   := Input.is_action_pressed("ui_right.5")
	var UP        := Input.is_action_pressed("ui_up")
	var DOWN      := Input.is_action_pressed("ui_down")
	var LEFT      := Input.is_action_pressed("ui_left" )
	var RIGHT     := Input.is_action_pressed("ui_right")

	var movedir :=  Vector2.ZERO

	movedir.x += -int(LEFT_h) + int(RIGHT_h)
	movedir.y += -int(UP_h)   + int(DOWN_h)

	movedir.x += -int(LEFT) + int(RIGHT)
	movedir.y += -int(UP)   + int(DOWN)

	return movedir
