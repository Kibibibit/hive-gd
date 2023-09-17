extends RefCounted
class_name Hex

const UP_LEFT_ID: int = 65535
const UP_RIGHT_ID: int = 131071
const RIGHT_ID: int = 65536
const DOWN_RIGHT_ID: int = 1
const DOWN_LEFT_ID: int = 4294901761
const LEFT_ID: int = 4294901760

const TILE_SIZE: int = 32
const RING_CORNER: int = 4

const MAX_SIZE: int = 16
const MAX_KEY: int = floori(pow(2, MAX_SIZE))-1

var q: int = 0
var r: int = 0
var s: int = 0

static func right() -> Hex:
	return Hex.axial(1,0)
static func up_right() -> Hex:
	return Hex.axial(1,-1)
static func up_left() -> Hex:
	return Hex.axial(0,-1)
static func left() -> Hex:
	return Hex.axial(-1,0)
static func down_left() -> Hex:
	return Hex.axial(-1,1)
static func down_right() -> Hex:
	return Hex.axial(0,1)



static func directions() -> Array[Hex]:
	return [
		Hex.right(),
		Hex.up_right(),
		Hex.up_left(),
		Hex.left(),
		Hex.down_left(),
		Hex.down_right(),
	]

static func direction_neighbours(direction: Hex) -> Array[Hex]:
	match(direction.get_id()):
		UP_LEFT_ID:
			return [Hex.left(), Hex.up_right()]
		UP_RIGHT_ID:
			return [Hex.right(), Hex.up_left()]
		RIGHT_ID:
			return [Hex.up_right(), Hex.down_right()]
		DOWN_RIGHT_ID:
			return [Hex.right(), Hex.down_left()]
		DOWN_LEFT_ID:
			return [Hex.down_right(), Hex.left()]
		LEFT_ID:
			return [Hex.down_left(), Hex.up_left()]
	return []

static func axial(p_q: int, p_r: int) -> Hex:
	var out: Hex = Hex.new()
	out.q = p_q
	out.r = p_r
	out.s = -p_q-p_r
	return out

static func cube(p_q: int, p_r:int, p_s: int) -> Hex:
	var out: Hex = Hex.new()
	out.q = p_q
	out.r = p_r
	out.s = p_s
	return out

func to_pixel_coords() -> Vector2:
	var x: int = floori(TILE_SIZE*(q+0.5*r)) 
	var y: int = floori(r*TILE_SIZE*0.75)
	return Vector2(x,y)

static func from_pixel_coords(pos: Vector2) -> Hex:
	pos -= Vector2(TILE_SIZE,TILE_SIZE)/2.0
	var p_q: float = (pos.x-(2.0/3.0)*pos.y)/TILE_SIZE
	var p_r: float = pos.y/(0.75*TILE_SIZE)
	return Hex.from_floats(p_q, p_r)

static func from_floats(q_float:float, r_float:float) -> Hex:
	var s_float: float = -q_float-r_float
	
	var p_q = round(q_float)
	var p_r = round(r_float)
	var p_s = round(s_float)

	var q_diff = abs(p_q-q_float)
	var r_diff = abs(p_r-r_float)
	var s_diff = abs(p_s-s_float)

	if q_diff > r_diff and q_diff > s_diff:
		p_q = -p_r-p_s
	elif r_diff > s_diff:
		p_r = -p_q-p_s
	else:
		p_s = -p_q-p_r

	
	return Hex.cube(p_q,p_r,p_s)

func get_id() -> int:
	assert(q <= MAX_KEY && q >= -MAX_KEY, "q coord too large!")
	assert(r <= MAX_KEY && r >= -MAX_KEY, "r coord too large!")
	var q_masked = q & MAX_KEY
	var r_masked = r & MAX_KEY
	return (q_masked << MAX_SIZE)+r_masked

func add(other: Hex) -> Hex:
	return Hex.axial(q+other.q, r+other.r)

func sub(other: Hex) -> Hex:
	return Hex.axial(q-other.q, r-other.r)

func get_neighbour(direction: int) -> Hex:
	assert(
		0 <= direction && direction < 6, 
		"Invalid direction %s! Valid range is [0, 5]" % direction 
	)
	return self.add(Hex.directions()[direction])

func neighbours() -> Array[Hex]:
	var out: Array[Hex] = []
	for n in Hex.directions():
		out.append(self.add(n))
	return out

func distance_to(other: Hex) -> float:
	return float(abs(q-other.q) + abs(q+r-other.q-other.r) + abs(r - other.r)) / 2.0

func scale(factor: int) -> Hex:
	return Hex.cube(q*factor, r*factor, s*factor)

func ring(radius:int) -> Array[Hex]:
	var out: Array[Hex] = []
	if (radius == 0):
		return [self]
	var hex: Hex = self.add(Hex.directions()[RING_CORNER].scale(radius))
	for i in 6:
		for j in radius:
			out.append(hex)
			hex = hex.get_neighbour(i)
	return out

func spiral(radius:int) -> Array[Hex]:
	var out: Array[Hex] = []
	for i in radius+1:
		out.append_array(ring(i))
	return out

func _to_string():
	return "<%s, %s, %s>" % [q, r, s]

func shared_neighbours(other: Hex)-> Array[Hex]:
	var out: Array[Hex] = []
	var direction: Hex = other.sub(self.copy())
	
	if (direction.distance_to(Hex.axial(0,0)) == 1.0):
		for n in Hex.direction_neighbours(direction):
			out.append(self.add(n))
	
	return out




func copy() -> Hex:
	return Hex.cube(q,r,s)
