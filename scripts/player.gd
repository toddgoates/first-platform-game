extends CharacterBody2D

# ---------------------------------------------------------
# CONSTANTS
# ---------------------------------------------------------

const SPEED := 130.0
const JUMP_VELOCITY := -300.0

const ROLL_SPEED := 250.0
const ROLL_DURATION := 0.35

const COYOTE_TIME := 0.15


# ---------------------------------------------------------
# STATE VARIABLES
# ---------------------------------------------------------

var is_rolling := false
var roll_timer := 0.0

var coyote_timer := 0.0


# ---------------------------------------------------------
# NODES
# ---------------------------------------------------------

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $SFX/JumpSound


# ---------------------------------------------------------
# ROLLING
# ---------------------------------------------------------

func start_roll() -> void:
	if is_rolling:
		return

	is_rolling = true
	roll_timer = ROLL_DURATION

	animated_sprite.play("roll")

	var dir := -1 if animated_sprite.flip_h else 1
	velocity.x = dir * ROLL_SPEED


func update_roll(delta: float) -> void:
	if not is_rolling:
		return

	roll_timer -= delta

	# Maintain constant roll velocity
	var dir := -1 if animated_sprite.flip_h else 1
	velocity.x = dir * ROLL_SPEED

	if roll_timer <= 0:
		is_rolling = false


# ---------------------------------------------------------
# PHYSICS / GAME LOOP
# ---------------------------------------------------------

func _physics_process(delta: float) -> void:
	update_coyote_time(delta)
	handle_input()
	apply_gravity(delta)

	update_roll(delta)
	apply_movement()
	play_animations()

	move_and_slide()


# ---------------------------------------------------------
# INPUT HANDLING
# ---------------------------------------------------------

func handle_input() -> void:
	# Jump
	if Input.is_action_just_pressed("jump") and coyote_timer > 0:
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
		coyote_timer = 0

	# Roll
	if Input.is_action_just_pressed("roll") and not is_rolling:
		start_roll()


# ---------------------------------------------------------
# MOVEMENT & PHYSICS
# ---------------------------------------------------------

func update_coyote_time(delta: float) -> void:
	coyote_timer = COYOTE_TIME if is_on_floor() else coyote_timer - delta


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func apply_movement() -> void:
	if is_rolling:
		return

	var direction := Input.get_axis("move_left", "move_right")

	# Flip direction
	if direction != 0:
		animated_sprite.flip_h = direction < 0

	# Apply horizontal movement
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)


# ---------------------------------------------------------
# ANIMATION
# ---------------------------------------------------------

func play_animations() -> void:
	if is_rolling:
		return

	if is_on_floor():
		if Input.get_axis("move_left", "move_right") == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
