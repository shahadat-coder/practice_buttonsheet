import 'package:flutter/material.dart';

void main() {
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOdo App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.cyan),
      themeMode: ThemeMode.light,
      home: const Todo(),
    );
  }
}

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final TextEditingController _titleEDController = TextEditingController();
  final TextEditingController _descripEDController = TextEditingController();

  List<MyTodo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
              onPressed: () {
                todos.clear();
                if (mounted) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.playlist_remove))
        ],
      ),
      body: ListView.separated(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: todos[index].isDone
                  ? const Icon(Icons.done)
                  : const Icon(Icons.account_box_rounded),
              title: Text(todos[index].name),
              subtitle: Text(todos[index].profession),
              trailing: const Icon(Icons.info),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          NewTodoModelSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void NewTodoModelSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 400,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                const Text(
                  "Add new infromation",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'FontMain'),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                TextField(
                  controller: _titleEDController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Name",
                    border:  OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                  ),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                TextField(
                  controller: _descripEDController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                    hintText: "Profession",
                    labelText: "Profession",
                  ),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60), // Set minimum height
                      padding: EdgeInsets.symmetric(vertical: 16), // Adjust vertical padding
                      backgroundColor: Colors.cyan, // Set background color
                      foregroundColor: Colors.black, // Set text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Set border radius
                      ),
                    ),
                    onPressed: () {
                      if (_titleEDController.text.trim().isNotEmpty &&
                          _descripEDController.text.trim().isNotEmpty) {
                        todos.add(MyTodo(_titleEDController.text,
                            _descripEDController.text, false));
                        if (mounted) {
                          setState(() {});
                        }
                        _titleEDController.clear();
                        _descripEDController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add')),
              ],
            ),
          );
        });
  }
}

class MyTodo {
  String name, profession;
  bool isDone;

  MyTodo(this.name, this.profession, this.isDone);
}
