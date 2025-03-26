import 'package:flutter/material.dart';
import 'package:mytask/models/task_model.dart';

class DetailTaskScreen extends StatelessWidget {
  Task task = Task();
  DetailTaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(task.title.toString())),
    );
  }
}
