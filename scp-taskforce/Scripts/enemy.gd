class_name EnemyDog
extends CharacterBody2D

enum State {DOG_RUN, DOG_BITE}

var state : State = State.DOG_RUN
@onready var player: Player = %Player
@export var stats : EnemyStats
var can_bite = true
@export var hitbox_shape : Shape2D

var health = 100

func _ready() -> void:
	$AnimatedSprite2D.flip_h = true
	$Health.set_max_health(stats.health)
	$Health.set_health($Health.max_health)
	$AnimatedSprite2D.sprite_frames = stats.sprite
	change_state(State.DOG_RUN)
	$BiteCooldown.wait_time = stats.atk_rate

func _physics_process(delta: float) -> void:
	player = %Player
	if player:
		var player_dir = position.direction_to(player.position)
		if position.distance_to(player.position) > stats.atk_range:
			velocity = stats.speed * player_dir
			change_state(State.DOG_RUN)
		else:
			change_state(State.DOG_BITE)
			velocity = Vector2.ZERO
			if can_bite:
				var hitbox = MeleeHitbox.new(stats.damage, 0.5, hitbox_shape, false)
				hitbox.position = $Muzzle.position
				add_child(hitbox)
				can_bite = false
				$BiteCooldown.start()
		look_at(player.position)
		move_and_slide()

func change_state(state : State):
	if state == State.DOG_RUN:
		$AnimatedSprite2D.play("dog_run")
		state = State.DOG_RUN
	
	if state == State.DOG_BITE:
		$AnimatedSprite2D.play("dog_idle")
		state = State.DOG_BITE


"""
when dog state is run
dog have no brain, bite player
dog is now queue_free()
"""


func _on_health_health_depleted() -> void:
	queue_free()


func _on_bite_cooldown_timeout() -> void:
	can_bite = true
