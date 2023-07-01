extends StaticBody2D

@onready var fire_sprite = $fire
@onready var fire_light = $PointLight2D

var sprite_min_size = 1.00
var sprite_max_size = 7.00
var sprite_size = 1.00

var light_min_energy = 0.15
var light_max_energy = 1.00
var light_energy = 1.00

var light_min_size = 1.00
var light_max_size = 5.00
var light_size = 5.00

var fuel = 1000
var max_fuel = 1000
var burn_rate = 10

func _ready():
	fire_sprite.play("default")

func _process(delta):
	if fuel > 0:
		fuel -= burn_rate * delta
	else:
		fuel = 0
		
	update_animation()
	
func update_animation():
	var fire_scale = (fuel/max_fuel)
	
	sprite_size = fire_scale * sprite_max_size
	if sprite_size < sprite_min_size:
		sprite_size = sprite_min_size
	elif sprite_size > sprite_max_size:
		sprite_size = sprite_max_size
		
	fire_sprite.scale = Vector2(sprite_size, sprite_size)
	
	light_energy = fire_scale * light_max_energy
	if light_energy < light_min_energy:
		light_energy = light_min_energy
	elif light_energy > light_max_energy:
		light_energy = light_max_energy
		
	fire_light.energy = light_energy
	
	light_size = fire_scale * light_max_size
	if light_size < light_min_size:
		light_size = light_min_size
	elif light_size > light_max_size:
		light_size = light_max_size
		
	fire_light.texture_scale = light_size
