import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/edit_screen.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane:
            ActionPane(extentRatio: 0.35, motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, EditScreen.routeName,arguments: task);
            },
            icon: Icons.edit,
            borderRadius: BorderRadius.circular(35),
            backgroundColor: AppColor.lightColor,
            label: 'Edit',
          )
        ]),
        startActionPane: ActionPane(
          extentRatio: 0.35,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                FireBaseFunctions.deleteTask(task.id);
              },
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(35),
              backgroundColor: Colors.red,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          elevation: 12,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent)),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 5,
                decoration: BoxDecoration(
                    color:
                        task.status ? AppColor.greenColor : AppColor.lightColor,
                    borderRadius: BorderRadius.circular(4)),
                margin: const EdgeInsets.only(
                    top: 6, bottom: 6, left: 20, right: 20),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.05,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: task.status
                            ? AppColor.greenColor
                            : AppColor.lightColor),
                  ),
                  Text(
                    task.des,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const Spacer(),
              task.status
                  ? Container(
                      margin: const EdgeInsets.only(right: 14, left: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 3),
                      child: Text(
                        "Done !",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColor.greenColor),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        task.status = true;
                        FireBaseFunctions.updateTask(task.id, task);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 16, left: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 30,
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
