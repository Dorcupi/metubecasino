extends VBoxContainer
class_name ShopItem

@export var title: String:
	set(new_value):
		title = new_value
		if title_label:
			title_label.text = new_value
@export var description: String:
	set(new_value):
		description = new_value
		if description_label:
			description_label.text = new_value
@export var price: float:
	set(new_value):
		price = new_value
		if buy_button:
			buy_button.text = "BUY - $%.2f" % new_value
@export var good_items: Array[WheelSegment]
@export var bad_items: Array[WheelSegment]
@onready var title_label: Label = $Title
@onready var description_label: Label = $Description
@onready var buy_button: Button = $BuyButton
signal purchase_item(good_items, bad_items, price)

func _on_buy_button_pressed() -> void:
	purchase_item.emit(good_items, bad_items, price)

func _ready() -> void:
	if title_label:
		title_label.text = title
	if description_label:
		description_label.text = description
	if buy_button:
		buy_button.text = "BUY - $%.2f" % price
