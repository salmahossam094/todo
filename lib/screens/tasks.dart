import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/task_item.dart';
import 'package:todo/shared/styles/app_colors.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {

    var pro = Provider.of<MyProvider>(context);
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColor.lightColor,
          selectedTextColor: Colors.white,
          height: 96,
          locale: pro.language,
          onDateChange: (newDate) {
            // New date selected
            setState(() {
              date = newDate;
            });
          },
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return TaskItem();
          },
          itemCount: 5,
        ))
      ],
    );
  }
}
