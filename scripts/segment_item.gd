extends VBoxContainer
class_name SegmentItem

@export var item: WheelSegment:
	set(new_value):
		item = new_value
		if rarity_label:
			if new_value and new_value.rarity:
				rarity_label.text = "Rarity %s" % int_to_roman(new_value.rarity)
			else:
				rarity_label.text = "Rarity Unknown"
		if texture_rect:
			if new_value and new_value.texture:
				texture_rect.texture = new_value.texture
			else:
				texture_rect.texture = null
@onready var texture_rect: TextureRect = $TextureRect
@onready var rarity_label: Label = $RarityLabel
@onready var insert_button: Button = $InsertButton
signal insert_item(node, item)

func _on_insert_button_pressed() -> void:
	insert_item.emit(self, item)

func _ready() -> void:
	if rarity_label:
		if item and item.rarity:
			rarity_label.text = "Rarity %s" % int_to_roman(item.rarity)
		else:
			rarity_label.text = "Rarity Unknown"
	if texture_rect:
		if item and item.texture:
			texture_rect.texture = item.texture
		else:
			texture_rect.texture = null

func int_to_roman(number: int) -> String:
	if number <= 0:
		return ""
	else:
		var romans: Array[String] = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
		var values: Array[int] = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
		
		var result: String = ""
		
		for i in range(values.size()):
			while number >= values[i]:
				number -= values[i]
				result = result + romans[i]
		
		return result
