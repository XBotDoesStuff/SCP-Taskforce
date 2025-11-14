class_name Navigator
extends Area2D

enum State {IDLE, MOVING}
const TILE_SIZE = Vector2(32, 32)
@onready var tile_map: AStarTileMap = $"../TileMap"

var grid_pos : Vector2i
@export var move_time = 0.05
var state = State.IDLE

var _click_position = Vector2()
var _path = PackedVector2Array()
var _next_point = Vector2i()

func _ready() -> void:
	global_position = tile_map.map_to_local(position)

func _process(delta: float) -> void:
	grid_pos = tile_map.local_to_map(position)
	
	if not state == State.IDLE:
		if grid_pos == _next_point:
			_path.remove_at(0)
			if not _path.is_empty():
				_next_point = _path[0]
				move_to(_next_point)
			else:
				change_state(State.IDLE)

func move_to(target):
	await get_tree().create_timer(move_time).timeout
	position = tile_map.map_to_local(target)

func path_to(target : Vector2i):
	if grid_pos != target:
		change_state(State.MOVING)
	_path = tile_map._get_path(grid_pos, target)

func change_state(new_state : State):
	state = new_state

func get_grid_pos(target) -> Vector2:
	return tile_map.local_to_map(target)
