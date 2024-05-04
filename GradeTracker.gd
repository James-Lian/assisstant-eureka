extends Control

var gradeInputs = []
var gpaLabel

func _ready():
	# Connect button signal to function
	var button = $Button
	button.connect("pressed", self, "_on_CalculateButton_pressed")

	# Populate gradeInputs array with LineEdit nodes
	for i in range($Subjects.get_child_count()):
		var child = $Subjects.get_child(i)
		if child is LineEdit:
			if child.name.starts_with("Grade"):
				gradeInputs.append(child)
	
	# Get reference to GPA Label
	gpaLabel = $GPA_Label

func _on_CalculateButton_pressed():
	var totalCredits = 0
	var weightedGradeSum = 0

	# Iterate through gradeInputs array
	for input in gradeInputs:
		var grade = input.text.to_float()
		if grade >= 0 and grade <= 100:
			var credits = input.get_parent().get_node(input.name.replace("Grade", "Credits")).text.to_int()
			if credits > 0:
				totalCredits += credits
				weightedGradeSum += grade * credits

	if totalCredits > 0:
		var gpa = weightedGradeSum / totalCredits
		gpaLabel.text = "GPA: " + str(round(gpa, 2))
	else:
		gpaLabel.text = "N/A"
