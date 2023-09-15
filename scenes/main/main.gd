extends Node



func _ready():
	var game_state: GameState = GameState.new()
	
	var queen = TileQueenBee.new()
	queen.hex = Hex.axial(1,0)
	#var bug2 = TileQueenBee.new()
	#bug2.hex = Hex.axial(-1, 0)
	
	game_state.place_tile(queen)
	#game_state.place_tile(bug2)
	
	var bugs: Array[Tile] = [
		TileQueenBee.new(),
		TileGrasshopper.new(),
		TileSoldierAnt.new(),
		TileBeetle.new(),
		TileSpider.new()
	]
	
	for bug in bugs:
		bug.hex = Hex.axial(0,0)
		game_state.place_tile(bug)
		print(bug.get_bug_name(),":",bug.get_valid_moves(game_state))
		game_state.remove_tile(bug)

