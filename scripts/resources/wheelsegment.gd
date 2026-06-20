extends Resource
class_name WheelSegment
## A segment of the wheel which adds a random effect to the total amount of money.

@export var texture: Texture2D
## The texture of the wheel segment.
@export var is_benefitial: bool
## Whether the result is benefitial to a players score or not.
@export var static_add_modifier: float
## A modifier to add (or subtract with negatives) onto the final return
@export var static_multiply_modifier: float
## A modifier to multiply (or divide with fractions) onto the final return

func add_modifier() -> ScoreUpdate:
	return
