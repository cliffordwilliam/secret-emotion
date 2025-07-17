class_name Player
extends CharacterBody2D

var speed = 40  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var vel = Vector2.ZERO  # The player's movement vector.
	if Input.is_action_pressed("right"):
		vel.x += 1
	if Input.is_action_pressed("left"):
		vel.x -= 1

	if vel.length() > 0:
		vel = vel.normalized() * speed
		$PlayerArmCombined.play("walk")
	else:
		$PlayerArmCombined.play("idle")

	position += vel * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if vel.x != 0:
		$PlayerArmCombined.flip_h = vel.x < 0
