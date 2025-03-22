import 'package:flutter/material.dart';
import 'package:mytask/screens/add_task_screen.dart';
import 'package:mytask/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        final widget = switch (settings.name ?? "") {
          '/addtask' => AddTaskScreen(),

          _ => const HomePage(),
        };
        return MaterialPageRoute(builder: (context) => widget);
      },
    );
  }
}
