class_name AStarTileMap
extends TileMapLayer

var astar_grid = AStarGrid2D.new()
const is_solid = "is_solid"

func init_astar():
	astar_grid.region = Rect2i(0, 0, 21, 13)
	astar_grid.cell_size = Vector2(32, 32)
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	for cell in get_used_cells():
		astar_grid.set_point_solid(cell, is_cell_solid(cell))

func is_cell_solid(cell : Vector2i) -> bool:
	if astar_grid.is_in_bounds(cell.x, cell.y):
		return get_cell_tile_data(cell).get_custom_data(is_solid)
	else:
		return false

func is_point_walkable(local_position):
	var map_position = local_to_map(local_position)
	if astar_grid.is_in_boundsv(map_position):
		return not astar_grid.is_point_solid(map_position)
	return false

func _get_path(start : Vector2i, target : Vector2i):
	return astar_grid.get_id_path(start, target)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_astar()
