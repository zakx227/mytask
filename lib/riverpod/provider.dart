import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/models/task_model.dart';
import 'package:mytask/riverpod/task_provider.dart';

final taskNotifierProvider = StateNotifierProvider<TaskProvider, List<Task>>(
  (ref) => TaskProvider(),
);
