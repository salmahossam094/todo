import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/widgets/task_item.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/app_colors.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime date = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          deactivatedColor: Colors.grey.shade400,
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColor.lightColor,
          monthTextStyle: TextStyle(
              color: pro.theme == ThemeMode.light ? Colors.black : Colors.white,
              fontSize: 12),
          dayTextStyle: TextStyle(
              color: pro.theme == ThemeMode.light ? Colors.black : Colors.white,
              fontSize: 12),
          dateTextStyle: TextStyle(
              color: pro.theme == ThemeMode.light ? Colors.black : Colors.white,
              fontSize: 25),
          height: 100,
          inactiveDates: [DateTime.now().add(Duration(days: 1))],
          selectedTextColor: Colors.white,
          onDateChange: (newDate) {
            // New date selected
            setState(() {
              date = newDate;
            });
          },
          locale: pro.language,
        ),
        Text('hi ${pro.myUser?.name}'),
        StreamBuilder(
          stream: FireBaseFunctions.getTasksFromFire(date),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('error');
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            if (tasks.isEmpty) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list),
                          SizedBox(
                            width: 10,
                          ),
                          Text(AppLocalizations.of(context)!.noTasks)
                        ],
                      ),
                    )
                  ],
                ),
              );
            }

            if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(tasks[index]);
                  },
                  itemCount: tasks.length,
                ),
              );
            }

            return CircularProgressIndicator();
          },
        )
      ],
    );
  }
}
