import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = 'Edit-Screen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void initState() {
    // Future.delayed(Duration.zero,() {
    //   var task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    //   titleController.text=task.title;
    //   descriptionController.text=task.des;
    //   date=DateTime.fromMillisecondsSinceEpoch(task.date);
    // },);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var task = ModalRoute.of(context)!.settings.arguments as TaskModel;
      titleController.text = task.title;
      descriptionController.text = task.des;
      date = DateTime.fromMillisecondsSinceEpoch(task.date);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    var pro =Provider.of<MyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'update task',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * .7,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Edit Task',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                  Divider(
                    thickness: 3,
                    color: AppColor.lightColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    enabled: true,
                    controller: titleController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColor.lightColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColor.lightColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(AppLocalizations.of(context)!.taskTitle),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(

                      prefixIcon: Icon(Icons.description),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: AppColor.lightColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: AppColor.lightColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(AppLocalizations.of(context)!.taskDescrip)
                    ),
                    controller: descriptionController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: pro.language=='en'?Alignment.topLeft:Alignment.topRight,
                    child: Text(
                   AppLocalizations.of(context)!.selectDate,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      chooseDate();
                      setState(() {});
                    },
                    child: Text(date.toString().substring(0, 10)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        task.title = titleController.text;
                        task.des = descriptionController.text;
                        task.date = date.millisecondsSinceEpoch;
                        FireBaseFunctions.updateTask(task.id, task);
                        Navigator.pop(context);
                      },
                      child: Text('       '))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chooseDate() async {
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 2)));
    if (selected != null) {
      date = selected;

      setState(() {});
    }
  }
}
