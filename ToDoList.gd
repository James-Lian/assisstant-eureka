extends Control

var taskInput
var addButton
var taskList

func _ready():
	# Get references to UI elements
	taskInput = $TaskInput
	addButton = $AddButton
	taskList = $TaskList

	# Connect button signal to function
	addButton.connect("pressed", Callable(self, "_on_AddButton_pressed"))

func _on_AddButton_pressed():
	# Get text from the input field
	var taskText = taskInput.text.strip_edges() # Remove leading/trailing whitespace

	# Check if input is not empty
	if taskText != "":
		# Create a new Label node for the task
		var newTask = Label.new()
		newTask.text = taskText
		
		# Add the task to the list
		taskList.add_child(newTask)
		
		# Clear the input field
		taskInput.text = ""
