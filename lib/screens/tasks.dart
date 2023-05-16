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
          inactiveDates: [DateTime.now().add(const Duration(days: 1))],
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColor.lightColor,
          selectedTextColor: Colors.white,
          deactivatedColor: Colors.grey,
          height: 96,
          locale: pro.language,
          monthTextStyle: pro.theme == ThemeMode.dark
              ? const TextStyle(color: Colors.white, fontSize: 15)
              : const TextStyle(color: AppColor.lightColor, fontSize: 15),
          dateTextStyle: pro.theme == ThemeMode.dark
              ? const TextStyle(color: Colors.white, fontSize: 15)
              : const TextStyle(color: AppColor.lightColor, fontSize: 15),
          dayTextStyle: pro.theme == ThemeMode.dark
              ? const TextStyle(color: Colors.white, fontSize: 15)
              : const TextStyle(color:AppColor.lightColor, fontSize: 15),
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
            return const TaskItem();
          },
          itemCount: 5,
        ))
      ],
    );
  }
}
