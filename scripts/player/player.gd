extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

enum Facing { LEFT, RIGHT }
enum State { IDLE, MOVING }

@export var max_speed = 400
@export var accel = 1800
@export var friction = 1800

var input = Vector2.ZERO
var facing = Facing.LEFT
var state = State.IDLE

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("walk_right")) - int(Input.is_action_pressed("walk_left"))
	input.y = int(Input.is_action_pressed("walk_down")) - int(Input.is_action_pressed("walk_up"))
	return input.normalized()

func get_facing(v_input):
	if v_input.x < 0:
		facing = Facing.LEFT
	elif v_input.x > 0:
		facing = Facing.RIGHT

func update_animation():
	if state == State.IDLE:
		if facing == Facing.LEFT:
			_animated_sprite.play("idle-left")
		elif facing == Facing.RIGHT:
			_animated_sprite.play("idle-right")
	elif state == State.MOVING:
		if facing == Facing.LEFT:
			_animated_sprite.play("walk-left")
		elif facing == Facing.RIGHT:
			_animated_sprite.play("walk-right")

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	
	if velocity == Vector2.ZERO:
		state = State.IDLE
	else:
		state = State.MOVING
	
	get_facing(input)
	update_animation()
	move_and_slide()
