!/bin/bash
# =====================================
#   Simple Menu-Driven To-Do List App
# =====================================

TODO_FILE="todo.txt"

# Function to add a task
add_task() {
    echo
    read -p "Enter task to add: " task
    echo "$task" >> "$TODO_FILE"
    echo " Task added: $task"
}

# Function to view all tasks
view_tasks() {
    echo
    if [ ! -f "$TODO_FILE" ] || [ ! -s "$TODO_FILE" ]; then
        echo " No tasks found."
    else
        echo " To-Do List:"
        nl -w2 -s'. ' "$TODO_FILE"
    fi
}

# Function to delete a task
delete_task() {
    echo
    if [ ! -f "$TODO_FILE" ] || [ ! -s "$TODO_FILE" ]; then
        echo " No tasks to delete."
        return
    fi

    view_tasks
    echo
    read -p "Enter task number to delete: " num

    if ! [[ "$num" =~ ^[0-9]+$ ]]; then
        echo " Invalid input. Please enter a number."
        return
    fi

    total=$(wc -l < "$TODO_FILE")
    if [ "$num" -le 0 ] || [ "$num" -gt "$total" ]; then
        echo " Invalid task number."
        return
    fi

    sed -i "${num}d" "$TODO_FILE"
    echo " Task deleted successfully."
}

# Main menu loop
while true; do
    echo
    echo "====================================="
    echo "       SIMPLE TO-DO LIST MANAGER"
    echo "====================================="
    echo "1. Add Task"
    echo "2. View Tasks"
    echo "3. Delete Task"
    echo "4. Exit"
    echo "-------------------------------------"
    read -p "Enter your choice (1-4): " choice

    case $choice in
        1) add_task ;;
        2) view_tasks ;;
        3) delete_task ;;
        4)
            echo " Exiting To-Do List Manager. Goodbye!"
            exit 0
            ;;
        *) echo " Invalid choice. Please enter 1-4." ;;
    esac
done