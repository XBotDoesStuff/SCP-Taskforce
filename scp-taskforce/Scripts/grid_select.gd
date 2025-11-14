extends Sprite2D

@onready var tile_map: AStarTileMap = $"../TileMap"

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	position = tile_map.map_to_local(tile_map.local_to_map(mouse_pos))
