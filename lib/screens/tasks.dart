import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/task_item.dart';
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
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColor.lightColor,
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
        StreamBuilder(
          stream: FireBaseFunctions.getTasksFromFire(date),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('error');
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            if (snapshot.hasData){
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
