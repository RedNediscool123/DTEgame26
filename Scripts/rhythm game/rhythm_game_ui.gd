extends Control
var score: int = 0
var combo_count: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	RhythmGameSignals.IncrementScore.connect(IncrementScore)
	RhythmGameSignals.IncrementCombo.connect(IncrementCombo)
	RhythmGameSignals.ResetCombo.connect(ResetCombo)
	
	
	ResetCombo()
func IncrementScore(incr: int):
	score += incr
	RhythmGameSignals.final_score = score
	%ScoreLabel.text = str(score)  + " pts"
func IncrementCombo():
	combo_count += 1
	if combo_count > RhythmGameSignals.best_combo:
		RhythmGameSignals.best_combo = combo_count
	%Combolabel.text = str(combo_count) + "x combo"
	
func ResetCombo():
	combo_count = 0
	%Combolabel.text = ""
