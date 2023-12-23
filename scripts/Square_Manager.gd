extends Node

func make_board(dark_color, light_color, window_dims):
	var column_indices = "abcdefgh".split()
	var row_indices = "12345678".split()
	var tile_side_len = window_dims.x / 8
	
	# Add tiles
	for row in range(8):
		for column in range(8):
			var square = Square.new(
				column_indices[column],
				row_indices[row],
				tile_side_len
			)
			
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
		
			# Add tiles to Tiles node
			add_child(square)

func get_square(f: String, r: String):
	return get_node("./" + f + r)
