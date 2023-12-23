extends Node2D

# Set tile manager equal to the Tiles node in scene tree
@onready var square_manager = $Square_Manager
@onready var piece_manager = $Piece_Manager
# Side length of board equal to viewport/window height
var window_dims = Vector2(600,1200)

func _ready():
	square_manager.make_board(Color.WHEAT, Color.SADDLE_BROWN, window_dims)
	piece_manager.initialize_pieces()
	piece_manager.render_fen("R1BK3R/p2ppp2")
