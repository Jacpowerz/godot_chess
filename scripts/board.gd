extends Node2D

# Set tile manager equal to the Tiles node in scene tree
@onready var square_manager = $Squares
@onready var piece_manager = $Pieces
# Side length of board equal to viewport/window height
var window_side_length = 600.0

class Square:
	
	extends ColorRect
	
	var body = ColorRect.new()
	var side_length = 20
	var center = Vector2.ZERO
	
	func _init(side_len = side_length):
		size = Vector2(side_len, side_len)
		
class Piece:
	
	extends Sprite2D
	
	var side = ""
	var current_square = Square.new()
	
	func move(target_square: Square):
		current_square = target_square
		position = target_square.center

func make_board(dark_color, light_color):
	var column_indices = "abcdefgh".split()
	var row_indices = "12345678".split()
	var rows = 8
	var columns = 8
	var tile_side_len = window_side_length / rows
	
	# Add tiles
	for row in range(rows):
		for column in range(columns):
			var square = Square.new(tile_side_len)
			
			square.position = Vector2 (
				column*tile_side_len,
				row*tile_side_len
			)
			
			square.center = square.position+Vector2(36.5,36.5)
			
			# Set alternating colors for light and dark squares
			if ((row+column) % 2 == 0):
				square.color = dark_color
			else:
				square.color = light_color
			
			# Set tile name to how it is in real life
			square.name = column_indices[column] + row_indices[row]
			
			# Add tiles to Tiles node
			square_manager.add_child(square)

func initialize_pieces():
	var base_path = "res://assets/tiles/64_"
	for i in range(1,13):
		
		# Change filepath based on index
		var piece_path = base_path + str(i) if (i >= 10) else base_path + "0" + str(i)
		var piece_image = load(piece_path+".png")
		
		var piece = Piece.new()
		piece.texture = piece_image
		piece.scale = Vector2(1.25,1.25)
		
		# Assign pieces to side (black or white)
		piece.side = "White" if (i <= 6) else "Black"
		
		match i:
			1: piece.name = "R"
			2: piece.name = "N"
			3: piece.name = "B"
			4: piece.name = "Q"
			5: piece.name = "K"
			6: piece.name = "P"
			7: piece.name = "r"
			8: piece.name = "n"
			9: piece.name = "b"
			10: piece.name = "q"
			11: piece.name = "k"
			12: piece.name = "p"
		
		piece.move($Squares/g8)
		piece_manager.add_child(piece)

func _ready():
	make_board(Color.WHEAT, Color.SADDLE_BROWN)
	initialize_pieces()
	print(piece_manager.get_child_count())
