extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 10.0
var max_speed = 500.0
var rot_speed = 6.0
var lives = 5

var nose = Vector2(0,-50)

var health = 70.0
var max_health = 70.0
onready var Bullet = load("res://Player/Bullet.tscn")
onready var Explosion = load("res://Effects/Explosion.tscn")
var Effects = null


func _ready():
	damage(0)

func _physics_process(_delta):
	velocity += get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide(velocity, Vector2.ZERO)
	position.x = wrapf(position.x, 0.0, Global.VP.x)
	position.y = wrapf(position.y, 0.0, Global.VP.y)


func get_input():
	var dir = Vector2.ZERO
	$Pivot/Exhaust.hide()
	if Input.is_action_pressed("up"):
		$Pivot/Exhaust.show()
		dir += Vector2(0,-1)
	if Input.is_action_pressed("left"):
		$Pivot.rotation_degrees -= rot_speed
		$Collision.rotation_degrees -= rot_speed
	if Input.is_action_pressed("right"):
		$Pivot.rotation_degrees += rot_speed
		$Collision.rotation_degrees += rot_speed
	if Input.is_action_just_pressed("shoot"):
		shoot()
	return dir.rotated($Pivot.rotation)


func shoot():
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var bullet = Bullet.instance()
		Effects.add_child(bullet)
		bullet.rotation = $Pivot.rotation
		bullet.global_position = global_position + nose.rotated($Pivot.rotation)


func damage(d):
	health -= d
	$Health.value = (health/max_health)*100
	var hb_color = $Health.get("custom_styles/fg")
	if $Health.value > 75.0:
		hb_color.set_bg_color(Color8(55, 178, 77))
	elif $Health.value > 40.0:
		hb_color.set_bg_color(Color8(255,212,59))
	else:
		hb_color.set_bg_color(Color8(224,49,49))
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			explosion.global_position = global_position
			Effects.add_child(explosion)
			Global.update_lives(-1)
		queue_free()



func _on_Area2D_body_entered(body):
	if body.name != "Player":
		if body.has_method("damage"):
			body.damage(100)
		damage(100)
