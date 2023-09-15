extends RefCounted
class_name Hex

const UP_LEFT_ID: int = 65535
const UP_RIGHT_ID: int = 131071
const RIGHT_ID: int = 65536
const DOWN_RIGHT_ID: int = 1
const DOWN_LEFT_ID: int = 4294901761
const LEFT_ID: int = 4294901760


const MAX_SIZE: int = 16
const MAX_KEY: int = floori(pow(2, MAX_SIZE))-1

var q: int = 0
var r: int = 0
var s: int = 0

static func up_left() -> Hex:
	return Hex.axial(0,-1)
static func up_right() -> Hex:
	return Hex.axial(1,-1)
static func right() -> Hex:
	return Hex.axial(1,0)
static func down_right() -> Hex:
	return Hex.axial(0,1)
static func down_left() -> Hex:
	return Hex.axial(-1,1)
static func left() -> Hex:
	return Hex.axial(-1,0)

static func directions() -> Array[Hex]:
	return [
		Hex.up_left(),
		Hex.up_right(),
		Hex.right(),
		Hex.down_right(),
		Hex.down_left(),
		Hex.left()
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

func neighbours() -> Array[Hex]:
	var out: Array[Hex] = []
	for n in Hex.directions():
		out.append(self.add(n))
	return out

func distance_to(other: Hex) -> float:
	return float(abs(q-other.q) + abs(q+r-other.q-other.r) + abs(r - other.r)) / 2.0

func _to_string():
	return "<%s, %s, %s>" % [q, r, s]

func shared_neighbours(other: Hex)-> Array[Hex]:
	var out: Array[Hex] = []
	var direction: Hex = other.sub(self)
	
	if (direction.distance_to(Hex.axial(0,0)) == 1.0):
		for n in Hex.direction_neighbours(direction):
			out.append(self.add(n))
	
	return out
