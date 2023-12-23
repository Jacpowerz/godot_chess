extends Node2D

# Side length of board equal to viewport/window height
var window_side_length = 600.0
# Set tile manager equal to the Tiles node in scene tree
@onready var tile_manager = $Tiles

class Tile:
	
	extends ColorRect
	
	var body = ColorRect.new()
	var side_length = 20
	
	func _init(side_len = side_length):
		size = Vector2(side_len, side_len)
		
	
	func _to_string():
		return "Tile: " + self.name + " with position: " + str(self.position)

func make_board():
	var column_indices = "abcdefgh".split()
	var row_indices = "12345678".split()
	var rows = 8
	var columns = 8
	var tile_side_len = window_side_length / rows
	
	# Add tiles
	for row in range(rows):
		for column in range(columns):
			var tile = Tile.new(tile_side_len)
			
			tile.position = Vector2 (
				column*tile_side_len,
				row*tile_side_len
			)
			
			# Set alternating colors for light and dark squares
			if ((row+column) % 2 == 0):
				tile.color = Color.RED
			else:
				tile.color = Color.BLUE
			
			# Set tile name to how it is in real life
			tile.name = column_indices[column] + row_indices[row]
			
			# Add tiles to Tiles node
			tile_manager.add_child(tile)
			

func _ready():
	make_board()
