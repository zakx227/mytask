import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/models/task_model.dart';
import 'package:mytask/riverpod/riverpod.dart';

import 'package:mytask/widgets/my_button.dart';
import 'package:mytask/widgets/my_inputfield.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  List<String> prioriteList = ['faible', 'moyenne', 'élevée'];
  List<String> statusList = ['à faire', 'en cours', 'termine'];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _date = DateTime.now();
  String _statusDefaultValue = 'à faire';
  String _prioriteDefaultValue = 'faible';

  bool champRenseigne = false;

  void ajoute() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      Task task = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _date.day.toString(),
        priority: _prioriteDefaultValue,
        status: _statusDefaultValue,
      );
      ref.read(taskRiverpod.notifier).addTasks(task);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Enregistré')));
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Veuillez renseigner toutes les informations',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyInputField(
                title: 'Task',
                hint: 'Titre',
                controller: _titleController,
              ),
              MyInputField(
                title: 'Description',
                hint: 'description',
                controller: _descriptionController,
              ),
              MyInputField(
                title: 'Date',
                hint:
                    _date.day.toString() +
                    '/' +
                    _date.month.toString() +
                    '/' +
                    _date.year.toString(),
                widget: IconButton(
                  onPressed: () {
                    _getDate();
                  },
                  icon: Icon(Icons.calendar_today_outlined),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Status',
                      hint: _statusDefaultValue,
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
                            _statusDefaultValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyInputField(
                      title: 'Priorite',
                      hint: _prioriteDefaultValue,
                      widget: DropdownButton(
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 32,
                        underline: Container(height: 0),
                        items:
                            prioriteList.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _prioriteDefaultValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              MyButton(title: 'Ajoute', onPressed: ajoute),
            ],
          ),
        ),
      ),
    );
  }

  _getDate() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2121),
    );

    if (pickerDate != null) {
      setState(() {
        _date = pickerDate;
      });
    }
  }
}
