import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/shared/styles/app_colors.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane:
            ActionPane(extentRatio: 0.35, motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
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
              onPressed: (context) {},
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
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(4)),
                margin: const EdgeInsets.only(
                    top: 6, bottom: 6, left: 20, right: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Title',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColor.lightColor),
                  ),
                  Text(
                    'Task Description',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const Spacer(),
              Container(
                  margin: const EdgeInsets.only(right: 16, left: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
