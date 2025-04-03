import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/riverpod/provider.dart';
import 'package:mytask/utils/constants.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
          'Gestion de tache',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
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
                                      : const Color.fromARGB(139, 76, 175, 79),
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
