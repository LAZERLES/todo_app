import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String API_URL = 'http://127.0.0.1:5001/todos';

  List todo_list = [];

  final task = TextEditingController();
  Future<List> fetchTodoList() async {
    final response = await http.get(Uri.parse(API_URL));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load todo list');
    }
  }

  Future<void> CreateTodo() async {
    final response = await http
        .post(
      Uri.parse(API_URL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'title': task.text}),
    )
        .then((value) {
      fetchTodoList().then((value) {
        print(value);
        setState(() {
          todo_list = value;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTodoList().then((value) {
      print(value);
      setState(() {
        todo_list = value;
      });
    });
  }

  void addtodo() {
    setState(() {
      todo_list.add(task.value.text);
      task.clear();
    });
  }

  void edittodo() {}

  void deletetodo(index) {
    setState(() {
      todo_list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: "To Do",
                        ),
                        keyboardType: TextInputType.text,
                        controller: task),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: CreateTodo,
                      child: Text("Add"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todo_list[index]['title']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deletetodo(index),
                      ),
                    );
                  },
                  itemCount: todo_list.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
