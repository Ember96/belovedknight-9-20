extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
@onready var camera_2d: Camera2D = $Player/Camera2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
		
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")
	move_and_slide()
