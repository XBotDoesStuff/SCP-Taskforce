class_name Equippable
extends Node2D
@onready var player: Player = %Player

@export var equippable_data : EquippableData
var interactable : bool = false

func _init(_equippable_data):
	equippable_data = _equippable_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = equippable_data.sprite
	$Sprite2D.scale = equippable_data.scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		
		if collider == player:
			interactable = true
		else:
			interactable = false
	
	if Input.is_action_just_pressed("interact"):
		if interactable:
			player.equip_weapon(WeaponInstance.new(equippable_data.weapon))
			queue_free()
