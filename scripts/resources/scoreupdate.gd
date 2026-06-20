extends Resource
class_name ScoreUpdate
## An update packet that contains the new score, alongside the message to show as the change

@export var new_score: float 
## The new score.
@export var message: String
## The message that explains what's the difference btween the old and new score.
@export var is_benefitial: bool
## Whether the new score is a increase or a decrease.
