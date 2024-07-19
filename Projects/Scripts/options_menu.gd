extends HBoxContainer

var resolutions : Dictionary = {
	"1920x1080":Vector2(1920,1080),
	"1600x900":Vector2(1600,900),
	"1280x720":Vector2(1280,720),
	"1024x600":Vector2(1024,600),
	"800x600":Vector2(800,600)}

var config = ConfigFile.new()
var res 

func _ready():
	var index = 0
	for i in resolutions:
		get_child(0).add_item(i,index)
		if Vector2i(resolutions[i]) == get_viewport().content_scale_size:
			$OptionsButton.select(index)
		index +=1
	res = get_viewport().content_scale_size

func _on_option_button_item_selected(index):
	res = resolutions.get(get_child(0).get_item_text(index))


func _on_apply_button_pressed():
	get_viewport().content_scale_size = res
	Resources.resolution[0] = res.x
	Resources.resolution[1] = res.y
	config.load("res://Config/config.ini")
	config.set_value("Settings","screen_width",int(res.x))
	config.set_value("Settings","screen_height",int(res.y))
	config.save("res://Config/config.ini")