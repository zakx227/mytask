import 'package:flutter/widgets.dart';
import 'package:mytask/models/data/database_helper.dart';
import 'package:mytask/models/task_model.dart';

class RiverpodTask extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  RiverpodTask() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    DatabaseHelper data = DatabaseHelper();
    _tasks = await data.getAllData();
    notifyListeners();
  }

  Future<void> addTasks(Task task) async {
    DatabaseHelper data = DatabaseHelper();

    data.insertData(task);
    loadTasks();
  }

  Future<void> deletedTask(int id) async {
    DatabaseHelper data = DatabaseHelper();
    data.deleteData(id);
    loadTasks();
  }
}
