import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/models/task_model.dart';
import 'package:mytask/screens/add_task_screen.dart';
import 'package:mytask/screens/detail_task_screen.dart';
import 'package:mytask/screens/home_screen.dart';
import 'package:mytask/notification/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        final widget = switch (settings.name ?? "") {
          '/addtask' => AddTaskScreen(),
          '/detailtask' => DetailTaskScreen(task: arguments as Task),
          '/home' => HomeScreen(),
          _ => HomeScreen(),
        };
        return MaterialPageRoute(builder: (context) => widget);
      },
    );
  }
}
