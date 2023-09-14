extends RefCounted
class_name HexGrid


const MAX_SIZE: int = 16
const MAX_KEY: int = floori(pow(2, MAX_SIZE))-1

const UP_LEFT: Vector2i = Vector2i(0, -1)
const UP_RIGHT: Vector2i = Vector2i(1, -1)
const LEFT: Vector2i = Vector2i(-1, 0)
const RIGHT: Vector2i = Vector2i(1, 0)
const DOWN_LEFT: Vector2i = Vector2i(-1, 1)
const DOWN_RIGHT: Vector2i = Vector2i(0, 1)

const AXIAL_DIRECTIONS: Array[Vector2i] = [
	UP_LEFT, UP_RIGHT, LEFT, RIGHT, DOWN_LEFT, DOWN_RIGHT
]


var _data: Dictionary = {}

static func get_coord_id(q: int, r:int) -> int:
	assert(q <= MAX_KEY && q >= -MAX_KEY, "p coord too large!")
	assert(r <= MAX_KEY && r >= -MAX_KEY, "q coord too large!")
	q = q & MAX_KEY
	r = r & MAX_KEY
	return (q << MAX_SIZE)+r

static func get_coord_id_v(v: Vector2i) -> int:
	return get_coord_id(v.x, v.y)

static func to_cube_coords(q: int, r:int) -> Vector3i:
	return Vector3i(q, r, -q-r)

static func axial_distance_v(a: Vector2i, b: Vector2i) -> float:
	return axial_distance(a.x, a.y, b.x, b.y)

static func axial_distance(q1: int, r1:int, q2:int, r2:int) -> float:
	var a: Vector3i = to_cube_coords(q1, r1)
	var b: Vector3i = to_cube_coords(q2, r2)
	var subbed = Vector3i(a.x-b.x, a.y-b.y, a.z-b.z)
	return (abs(subbed.x) + abs(subbed.y) + abs(subbed.z))/2
	

func get_at(q:int, r:int) -> TileStack:
	var key = HexGrid.get_coord_id(q,r)
	if (!key in _data):
		_data[key] = TileStack.new(q,r)
	return _data[key]

func get_at_v(v: Vector2i) -> TileStack:
	return get_at(v.x, v.y)

func set_at(value, q:int, r:int)->void:
	_data[HexGrid.get_coord_id(q,r)] = value

func set_at_v(value, v: Vector2i) -> void:
	set_at(value, v.x,v.y)

func get_neighbours(q: int, r:int) -> Array[Vector2i]:
	return get_neighbours_v(Vector2i(q,r))

func get_neighbours_v(v: Vector2i)-> Array[Vector2i]:
	var out: Array[Vector2i] = []
	for direction in AXIAL_DIRECTIONS:
		var n_pos = v+direction
		out.append(n_pos)
	return out

func get_non_empty_tiles(exclude: Array[Vector2i] = []) -> Array[Vector2i]:
	var out: Array[Vector2i] = []
	for key in _data.keys():
		var stack: TileStack = _data[key]
		if (!stack.tiles.is_empty() && !stack.pos in exclude):
			out.append(stack.pos)
		
	return out
