extends Sprite2D
class_name Piece
# Had to do it like this because it kept being null as the path changed
@onready var board = get_tree().get_root().get_node("Board")
@onready var square_manager = board.get_node("Square_Manager")
# side is either white or black
var side = ""
var current_square = null
var type = ""

func _init(piece_type = type, cur_square=current_square, color="White", pos=Vector2(-100,-100)):
	type = piece_type
	current_square = cur_square
	side = color
	position = pos # just off the board
	
func move(file: String, rank: String):
	var target_square = square_manager.get_square(file, rank)
	current_square = target_square
	position = target_square.center
