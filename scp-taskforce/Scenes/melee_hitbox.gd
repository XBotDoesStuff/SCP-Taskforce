class_name MeleeHitbox
extends Hitbox

var time_to_live : float
var shape : Shape2D
var friendly: bool

func _init(_damage: float, _time_to_live, _shape : Shape2D, _friendly : bool) -> void:
	damage = _damage
	time_to_live = _time_to_live
	shape = _shape
	friendly = _friendly

func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)
	
	if time_to_live > 0:
		var timer = Timer.new()
		add_child(timer)
		timer.timeout.connect(queue_free)
		timer.call_deferred("start", time_to_live)
	if shape:
		var collision_shape = CollisionShape2D.new()
		collision_shape.shape = shape
		add_child(collision_shape)
		
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)

func _on_area_entered(area: Hurtbox) -> void:
	area.take_damage(damage)
	print("collisionsosn")
