import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/app_colors.dart';

class ShowFloatingBottom extends StatefulWidget {
  const ShowFloatingBottom({Key? key}) : super(key: key);

  @override
  State<ShowFloatingBottom> createState() => _ShowFloatingBottomState();
}

class _ShowFloatingBottomState extends State<ShowFloatingBottom> {
  var formKey = GlobalKey<FormState>();
  DateTime date = DateUtils.dateOnly(DateTime.now());
  var titleController = TextEditingController();
  var desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.addNew,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: pro.theme == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.error1;
                  } else if (value.length < 5) {
                    return AppLocalizations.of(context)!.error2;
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text(AppLocalizations.of(context)!.taskTitle),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.title),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: desController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.error3;
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                maxLines: 3,
                decoration: InputDecoration(
                  label: Text(AppLocalizations.of(context)!.taskDescrip),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.description),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lightColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.selectDate,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: pro.theme == ThemeMode.light
                          ? Colors.black
                          : Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  chooseDate();
                },
                child: Text(
                  date.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: pro.theme == ThemeMode.light
                          ? AppColor.lightColor
                          : Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      title: titleController.text,
                      des: desController.text,
                      date: date.millisecondsSinceEpoch,
                      status: false,
                    );
                    FireBaseFunctions.addTasksToFire(task);
                    Navigator.pop(context);
                  }
                },
                child: Text(AppLocalizations.of(context)!.addTask),
              ),
            ],
          ),
        ),
      ),
    );
  }

  chooseDate() async {
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 2)));
    if (selected != null) {
      date = DateUtils.dateOnly(selected);
    }
    setState(() {});
  }
}
