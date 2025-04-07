import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/models/task_model.dart';
import 'package:mytask/notification/notification.dart';
import 'package:mytask/riverpod/provider.dart';
import 'package:mytask/utils/constants.dart';
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
  final TextEditingController _notificationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _date = DateTime.now();
  String _statusDefaultValue = 'à faire';
  String _prioriteDefaultValue = 'faible';

  //----------------------Fonction Ajoute-----------------------------------
  void add() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      String finalDate = '${_date.day}/${_date.month}/${_date.year}';

      Task task = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: finalDate,
        priority: _prioriteDefaultValue,
        status: _statusDefaultValue,
      );
      ref.read(taskNotifierProvider.notifier).addTasks(task);

      //---------------------------Notification

      int seconds = int.tryParse(_notificationController.text) ?? 0;
      if (seconds > 0) {
        NotificationHelper().repeatPeriodicallyWithDurationNotification(
          'Alert',
          'La tache ${_titleController.text} doit etre termine...',
          seconds,
        );
      }
      //------------------------------------------------------------------
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tache ajoutée avec succès !',
            style: TextStyle(color: couleurPrincipale),
          ),
          backgroundColor: Colors.white,
        ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Veuillez remplir tous les champs obligatoires avant d\'ajouter la tache.',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }
  //----------------------------------Fin fonction ajoute------------------------------------

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
                title: 'Tache',
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
                hint: '${_date.day}/${_date.month}/${_date.year}',
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
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Planifier Notification (facultatif)'),
                    hintText: 'Délais (en secondes min 60)',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                  ),
                  controller: _notificationController,
                ),
              ),
              SizedBox(height: 20),
              MyButton(
                title: 'Ajoute',
                onPressed: add,
                color: couleurPrincipale,
              ),
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
