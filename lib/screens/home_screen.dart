import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mytask/notification/notification.dart';
import 'package:mytask/riverpod/provider.dart';
import 'package:mytask/utils/constants.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listTask = ref.watch(taskNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Text(''),
        title: Text(
          'Gestion De Tache',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: TextStyle(
                fontSize: 20,
                color: couleurPrincipale,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yMMMMd').format(_date),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      backgroundColor: couleurPrincipale,
                    ),
                    onPressed: () {
                      NotificationHelper.cancelAllNotifications();
                    },
                    child: Text(
                      'Close Notif',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                onChanged: (value) {
                  ref.read(taskNotifierProvider.notifier).filterTask(value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Recherche par status',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            listTask.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                    itemCount: listTask.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/detailtask',
                                arguments: listTask[index],
                              ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color:
                                  listTask[index].status != 'termine'
                                      ? const Color.fromARGB(54, 158, 158, 158)
                                      : const Color.fromARGB(35, 2, 44, 252),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      listTask[index].title!,
                                      style: TextStyle(
                                        fontSize: 21,
                                        color: couleurPrincipale,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      listTask[index].dueDate!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(listTask[index].description!),
                                SizedBox(height: 10),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Priority : ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(listTask[index].priority!),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            'Status : ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(listTask[index].status!),
                                        ],
                                      ),
                                      if (listTask[index].status == 'termine')
                                        Icon(Icons.verified_rounded),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                : Text(
                  'Aucune tache enregistrée. Ajoutez votre première tache pour commencer !',
                  style: TextStyle(fontSize: 18, color: couleurPrincipale),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: couleurPrincipale,
        child: Icon(Icons.add, size: 35, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/addtask');
        },
      ),
    );
  }
}
