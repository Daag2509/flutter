import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'get.dart';
import 'post.dart';
import 'patch.dart';
import 'delete.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://sdxtdbifudstjfxzmyhp.supabase.co', 
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNkeHRkYmlmdWRzdGpmeHpteWhwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMyOTIxMjIsImV4cCI6MjA2ODg2ODEyMn0.aeZpl4sTZxdfhBzy4qFUiXwrLq4eL8ABHsE6nWbxu6M', 
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _todos = [];

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    _todos = await fetchTodos(); // Llama a la función de get.dart
    setState(() {});
  }

  Future<void> _addTodo() async {
    if (_controller.text.isEmpty) return;
    await addTodo(_controller.text); // Llama a la función de post.dart
    _controller.clear();
    _fetchTodos();
  }

  Future<void> _toggleTodoCompletion(int id, bool completed) async {
    await updateTodoCompletion(id, !completed); // Llama a la función de patch.dart
    _fetchTodos();
  }

  Future<void> _deleteTodo(int id) async {
    await deleteTodo(id); // Llama a la función de delete.dart
    _fetchTodos();
  }

  Future<void> _clearCompleted() async {
    await deleteCompleted(); // Llama a la función de delete.dart
    _fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _clearCompleted,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Agregar nueva tarea',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(
                    todo['task'],
                    style: TextStyle(
                      decoration: todo['completed']
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: Checkbox(
                    value: todo['completed'],
                    onChanged: (value) {
                      _toggleTodoCompletion(todo['id'], todo['completed']);
                    },
                  ),
                  onLongPress: () => _deleteTodo(todo['id']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}