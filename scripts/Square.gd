extends ColorRect
class_name Square

var body = ColorRect.new()
var side_length = 20
var center = Vector2.ZERO
var rank = name.get_slice("", 0)
var file = name.get_slice("", 1)
	
func _init(f, r, side_len = side_length):
	size = Vector2(side_len, side_len)
	file = f
	rank = r
	name = file+rank
