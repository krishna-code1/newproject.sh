#!/bin/bash

#File in which taska are stored:
TODO_FILE="todo.txt"

#Make sure  todo file exists:
if [ ! -f "TODO_FILE" ]; then
	touch "$TODO_FILE"
fi

#Function to display menu
show_menu() {
echo "To-Do list manager"
echo "-------------------"
echo "1. Add Task"
echo "2. View Tasks"
echo "3. Delete Task"
echo "4. Exit"
echo "-------------------"
echo -n "Choose an option:"
}

#Funtion to add a task:
add_task() {
echo -n "Enter task:"
read task
if [ -n "$task" ]; then
	echo "$task">>"$TODO_FILE"
	echo "Task added."
else
	echo "Task cannot be empty!"
fi
}

#Function to view tasks
view_tasks() {
if [ ! -s "$TODO_FILE" ]; then
	echo "No tasks found!"
else
	echo "Your To-Do List:"
	nl -w2 -s'. ' "$TODO_FILE" #Numbered list
fi
}

#Function to delete a task
delete_task() {
view_tasks
if [ ! -s "$TODO_FILE" ]; then
	return
fi
echo -n "Enter the task number to delete:"
read task_number
if [[ $task_number =~ ^[0-9]+$ ]]; then
	sed -i "${task_number}d" "$TODO_FILE" 2>/dev/null
	echo "Task deleted."
else
	echo "Invalid input!"
fi
}

#Main loop
while true; do
	show_menu
	read choice
	case $choice in
	1) add_task;;
	2) view_tasks;;
	3) delete_task;;
	4) echo "Goodbye!"; exit 0;;
	*) echo "Invalid choice! Please select 1-4." ;;
esac
done
