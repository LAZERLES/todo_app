import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List todo_list = [];

  final task = TextEditingController();

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
                      onPressed: addtodo,
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
                      title: Text(todo_list[index]),
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
