import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/models/data/database_helper.dart';
import 'package:mytask/models/task_model.dart';

class TaskProvider extends StateNotifier<List<Task>> {
  final DatabaseHelper data = DatabaseHelper();
  List<Task> allTask = [];

  TaskProvider() : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    allTask = await data.getAllData();
    state = allTask;
  }

  Future<void> addTasks(Task task) async {
    await data.insertData(task);
    loadTasks();
  }

  Future<void> deletedTask(int id) async {
    await data.deleteData(id);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await data.updateData(task);
    loadTasks();
  }

  void filterTask(String s) {
    if (s.isEmpty) {
      state = allTask;
    } else {
      state =
          allTask
              .where((p) => p.status!.toLowerCase().contains(s.toLowerCase()))
              .toList();
    }
  }
}
