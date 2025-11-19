import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxiapp_mobile/core/entities/todo_tasks/todo_tasks.dart';
import 'package:taxiapp_mobile/shared/theme/app_colors.dart';

class TodoTasksWidget extends StatelessWidget {
  final TodoTasks todoTaskModel;

  const TodoTasksWidget({super.key, required this.todoTaskModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 30.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todoTaskModel.title,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  todoTaskModel.description,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
            // add a label for the priority
            Container(
              width: 120.w,
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: getPriorityColor(priority: todoTaskModel.priority)
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(
                  color: getPriorityColor(priority: todoTaskModel.priority),
                  width: 1.5.w,
                ),
              ),
              child: Center(
                child: Text(
                  todoTaskModel.priority,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyMedium
                      ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: getPriorityColor(
                              priority: todoTaskModel.priority)),
                ),
              ),
            )
          ],
        ));
  }
}

// create a function that uses a case statement to return the priority color
Color getPriorityColor({required String priority}) {
  switch (priority) {
    case 'IMPORTANT':
      return Colors.red;
    case 'URGENT':
      return Colors.orange;
    case 'NORMAL':
      return Colors.green;
    default:
      return PRIMARY_COLOR;
  }
}
