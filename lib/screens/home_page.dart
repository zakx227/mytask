import 'package:flutter/material.dart';
import 'package:mytask/Data/database_helper.dart';
import 'package:mytask/models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper data = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Text(''), title: Text('Todo List')),
      body: Expanded(
        child: FutureBuilder<List<Task>>(
          future: data.getAllData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final tasksList = snapshot.data!;

            return ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(tasksList[index].id.toString()));
              },
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 15),
            backgroundColor: Colors.blue,
            iconColor: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/addtask');
          },
          child: Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
