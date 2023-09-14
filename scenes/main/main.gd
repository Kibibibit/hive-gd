extends Node



func _ready():
	var board: GameBoard = GameBoard.new()
	
	board.grid.get_at_v(Vector2i(1,0)).tiles.append(1)
	board.grid.get_at_v(Vector2i(-1, 1)).tiles.append(1)
	board.grid.get_at_v(Vector2i(0,1)).tiles.append(1)
	
	var bugs: Array[Tile] = [
		TileQueenBee.new(),
		TileGrasshopper.new(),
		TileSoldierAnt.new(),
		TileBeetle.new(),
		TileSpider.new()
	]
	
	for bug in bugs:
		bug.hex_pos = Vector2i(0,0)
		board.grid.get_at_v(Vector2i(0,0)).tiles.clear()
		board.grid.get_at_v(Vector2i(0,0)).tiles.append(bug.get_instance_id())
		print(bug)
		print(board.can_move_tile(bug))
		print(bug.get_reachable_tiles(board))
		print("-")

