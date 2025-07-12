import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:girly_todo_app/models/todo_item.dart';

class TodoListPage extends StatefulWidget { // Fix: Changed _TodoListState to TodoListState to match convention
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState(); // Fix: Pointing to correct State class
}

class _TodoListPageState extends State<TodoListPage> { // Fix: Inherit from State<TodoListPage>
  late Box<TodoItem> _todoItemsBox;
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _todoItemsBox = Hive.box<TodoItem>('todoItemsBox');
  }

  void _addTodoItem() {
    if (_todoController.text.isNotEmpty) {
      final newItem = TodoItem(
        title: _todoController.text,
        createdAt: DateTime.now(),
      );
      _todoItemsBox.add(newItem);
      _todoController.clear();
      setState(() {});
    }
  }

  void _toggleTodoStatus(TodoItem item) {
    item.isCompleted = !item.isCompleted;
    item.save();
    setState(() {});
  }

  void _deleteTodoItem(int index) {
    _todoItemsBox.deleteAt(index);
    setState(() {});
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<TodoItem> sortedTodos = _todoItemsBox.values.toList()
      ..sort((a, b) {
        if (a.isCompleted == b.isCompleted) {
          return a.createdAt.compareTo(b.createdAt);
        } else {
          return a.isCompleted ? 1 : -1;
        }
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new fabulous task...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add_circle, color: Theme.of(context).primaryColor),
                        onPressed: _addTodoItem,
                      ),
                    ),
                    onSubmitted: (_) => _addTodoItem(),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Expanded(
            child: sortedTodos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.spa_outlined, size: 80, color: Colors.pink.shade200),
                        const SizedBox(height: 10),
                        Text(
                          'All tasks done, you rock!',
                          style: GoogleFonts.dancingScript(
                              fontSize: 24, color: Colors.pink.shade400),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: sortedTodos.length,
                    itemBuilder: (context, index) {
                      final todo = sortedTodos[index];
                      final originalIndex = _todoItemsBox.values.toList().indexOf(todo);

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            todo.title,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                              color: todo.isCompleted ? Colors.grey.shade600 : Colors.pink.shade900,
                            ),
                          ),
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (bool? value) {
                              _toggleTodoStatus(todo);
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_forever, color: Colors.pink.shade300),
                            onPressed: () => _deleteTodoItem(originalIndex),
                          ),
                          onTap: () => _toggleTodoStatus(todo),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}