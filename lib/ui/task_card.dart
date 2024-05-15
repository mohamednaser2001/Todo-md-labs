

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controller/todo_controller.dart';
import '../core/color_manager.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.function});

  final TaskModel task;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(end: 10.w, top: 4.h, bottom: 4.h),
      decoration: BoxDecoration(
          color: AppColors.cardColor,
          border: Border.all(color: const Color(0xff675f53)),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          Checkbox(
              value: task.isDone,
              activeColor: Colors.green,
              onChanged: (value) {
                function();
              }),
          Expanded(
            child: Text(
              task.task,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                decorationColor: Colors.white,
                decoration: task.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}