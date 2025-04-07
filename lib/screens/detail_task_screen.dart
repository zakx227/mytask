import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/models/task_model.dart';
import 'package:mytask/riverpod/provider.dart';
import 'package:mytask/utils/constants.dart';
import 'package:mytask/widgets/my_button.dart';
import 'package:mytask/widgets/my_inputfield.dart';

class DetailTaskScreen extends ConsumerStatefulWidget {
  final Task task;

  const DetailTaskScreen({super.key, required this.task});

  @override
  ConsumerState<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends ConsumerState<DetailTaskScreen> {
  List<String> statusList = ['à faire', 'en cours', 'termine'];
  String statusDefaultValue = 'à faire';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyInputField(
                title: 'Tache',
                hint: widget.task.title!,
                widget: Container(),
              ),
              MyInputField(
                title: 'Description',
                hint: widget.task.description!,
                widget: Container(),
              ),
              MyInputField(
                title: 'Date',
                hint: widget.task.dueDate!,
                widget: Container(),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Status',
                      hint: widget.task.status!,
                      widget: DropdownButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 32,
                        underline: Container(height: 0),
                        items:
                            statusList.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            widget.task.status = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              MyButton(
                title: 'UPDATE',
                onPressed: () {
                  ref
                      .read(taskNotifierProvider.notifier)
                      .updateTask(widget.task);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Tache mise à jour avec succès.',
                        style: TextStyle(color: couleurPrincipale),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  );
                  Navigator.pushReplacementNamed(context, '/home');
                },
                color: Color(0xFF3787EB),
              ),
              SizedBox(height: 10),
              MyButton(
                title: 'DELETED',
                onPressed: () {
                  ref
                      .read(taskNotifierProvider.notifier)
                      .deletedTask(widget.task.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Tache supprimée avec succès.',
                        style: TextStyle(color: Colors.red),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  );
                  Navigator.pushReplacementNamed(context, '/home');
                },
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
