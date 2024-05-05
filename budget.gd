extends Control

var incomes: Dictionary = {}
var expenses: Dictionary = {}

@onready var IncomeExpenseLine = get_node("Control/MarginContainer2/VBoxContainer/LineEdit")
@onready var AmountLine = get_node("Control/MarginContainer2/VBoxContainer/SpinBox")
@onready var IESelect = get_node("Control/MarginContainer2/VBoxContainer/HBoxContainer/OptionButton")

@onready var IEViewing = $MarginContainer/VBoxContainer/HBoxContainer/OptionButton
@onready var Scroll = $MarginContainer/VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer

var listitem = preload("res://incomeexpensedisplay.tscn")

@onready var Balance = $MarginContainer/VBoxContainer/Panel2/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer2/HBoxContainer/Balance
@onready var Income_text = $MarginContainer/VBoxContainer/Panel2/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Income
@onready var Expenses_text = $MarginContainer/VBoxContainer/Panel2/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/Expenses

@onready var Percentage = $MarginContainer/VBoxContainer/Panel2/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/ProgressBar

func update_budget():
	# clearing the list
	for n in Scroll.get_children(0):
		Scroll.remove_child(n)
		n.queue_free()
	
	if IEViewing.selected == 0:
		for income in incomes:
			var instance = listitem.instantiate()
			Scroll.add_child(instance)
			instance.get_node("Label").text = str(income)
			instance.get_node("Label2").text = str(incomes[income])
			
			instance.connect("removed", Callable(self, "remove_income_expense"))
	elif IEViewing.selected == 1:
		for expense in expenses:
			var instance = listitem.instantiate()
			Scroll.add_child(instance)
			instance.get_node("Label").text = str(expense)
			instance.get_node("Label2").text = str(expenses[expense])
			
			instance.connect("removed", Callable(self, "remove_income_expense"))
	
	var total_income: float
	for income in incomes:
		total_income += incomes[income]
	var total_expenses: float
	for expense in expenses:
		total_expenses += expenses[expense]
	
	Income_text.text = "$" + str(total_income)
	Expenses_text.text = "$" + str(total_expenses)
	
	if total_income - total_expenses < 0:
		Balance.text = "-$" + str(abs(total_income - total_expenses))
	else:
		Balance.text = "$" + str(total_income - total_expenses)
	
	if (total_income + total_expenses) == 0:
		Percentage.value = 50
	else:
		Percentage.value = int(total_income / (total_income + total_expenses) * 100)

func _on_option_button_item_selected(index):
	update_budget()

func _on_add_pressed():
	$Control.show()

func _on_ok_pressed():
	# income
	if IESelect.selected == 0:
		if IncomeExpenseLine not in incomes:
			incomes[IncomeExpenseLine.text] = int(AmountLine.value)
			update_budget()
	# expense
	elif IESelect.selected == 1:
		if IncomeExpenseLine not in expenses:
			expenses[IncomeExpenseLine.text] = int(AmountLine.value)
			update_budget()
	
	if (IESelect.selected == 0 and IncomeExpenseLine not in incomes) or (IESelect.selected == 1 and IncomeExpenseLine not in expenses):
		IncomeExpenseLine.text = ""
		AmountLine.value = 0
		IESelect.selected = -1
		$Control.hide()

# cancel
func _on_ok_2_pressed():
	IncomeExpenseLine.text = ""
	AmountLine.value = 0
	IESelect.selected = -1
	$Control.hide()
	
func set_title(string):
	$MarginContainer/VBoxContainer/Panel/MarginContainer/Title.text = string

func remove_income_expense(identifier):
	if IEViewing.selected == 0:
		incomes.erase(identifier)
	else:
		expenses.erase(identifier)
		
	update_budget()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://new.tscn")
