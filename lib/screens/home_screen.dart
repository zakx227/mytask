import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/riverpod/riverpod.dart';
import 'package:mytask/utils/constants.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listTask = ref.watch(taskRiverpod);

    return Scaffold(
      body: ListView.builder(
        itemCount: listTask.tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: couleurPrincipale,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      listTask.tasks[index].title!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: couleurPrincipale,
        onPressed: () {
          Navigator.pushNamed(context, '/addtask');
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
