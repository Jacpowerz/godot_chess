extends Node

@onready var square_manager = $"../Square_Manager"

func get_piece(piece_name: String):
	return get_node("./"+piece_name)

func initialize_pieces():
	var base_path = "res://assets/tiles/64_"
	for i in range(1,13):
		
		# Change filepath based on index
		var piece_path = base_path + str(i) if (i >= 10) else base_path + "0" + str(i)
		var piece_image = load(piece_path+".png")
		
		var piece = Piece.new()
		piece.texture = piece_image
		piece.scale = Vector2(1.25,1.25)
		piece.visible = false
		
		piece.side = "White" if (i > 6) else "Black"

		match i:
			1: piece.name = "r"
			2: piece.name = "n"
			3: piece.name = "b"
			4: piece.name = "q"
			5: piece.name = "k"
			6: piece.name = "p"
			7: piece.name = "R"
			8: piece.name = "N"
			9: piece.name = "B"
			10: piece.name = "Q"
			11: piece.name = "K"
			12: piece.name = "P"
		add_child(piece)

func render_fen(fen_string: String):
	
	var file_indices = "abcdefgh".split()
	var current_square = square_manager.get_square("a", "1")
	
	# for every char in the fen string
	for fen in fen_string:
		# define some numbers i need
		var current_file_num = file_indices.find(current_square.file, 0) + 1
		var current_rank = int(current_square.rank)
		if fen.is_valid_int():
			var next_file_num = current_file_num + int(fen)
			
			while next_file_num > 8:
				current_rank += 1
				next_file_num -= 8
			
			current_square = square_manager.get_square(
				file_indices[next_file_num-1],
				str(current_rank)
			)
		# increment the rank properly
		elif fen == "/":
			current_square = square_manager.get_square(
				"a", str(current_rank+1)
			)
		else:
			# add pieces to that spot
			var piece = get_piece(fen).duplicate()
			print(piece)
			piece.visible = true
			piece.move(current_square.file, current_square.rank)
			print(current_square.name)
			current_square = square_manager.get_square(
				file_indices[current_file_num%8], # ngl idk why mod 8 works here
				str(current_rank)
			)
