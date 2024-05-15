
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_md_labs/core/color_manager.dart';
import 'package:todo_md_labs/controller/todo_controller.dart';
import 'package:todo_md_labs/ui/task_card.dart';

import '../models/task_model.dart';

class TodosScreen extends StatelessWidget {
  TodosScreen({super.key});

  final ToDoController todoController = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0d0d0d),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 120.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grayColor),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Todo Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                          ),
                          Text(
                            'Keep it up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.redColor,
                        radius: 40.r,
                        child: GetBuilder<ToDoController>(
                            id: 'tasks',
                            builder: (controller) {
                              return Text(
                                '${controller.doneTasks}/${controller.allTasks.length}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp),
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: todoController.taskController,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'Write your next task ...',
                          hintStyle: TextStyle(
                              color: AppColors.grayColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                          fillColor: AppColors.cardColor,
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 16.w),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16.r)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16.r)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16.r)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        if(todoController.taskController.text.trim().isNotEmpty){
                          todoController.saveTask(todoController.taskController.text.trim());
                        }
                      },
                      child: CircleAvatar(
                          backgroundColor: AppColors.redColor,
                          radius: 20.r,
                          child: const Icon(Icons.add, color: Colors.black,)),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: GetBuilder<ToDoController>(
                      id: 'tasks',
                      builder: (controller) {
                        return controller.loadWhileGetTasks == true
                            ? const CircularProgressIndicator()
                            : controller.allTasks.isEmpty
                            ? Center(
                          child: Text(
                            'No tasks yet',
                            style: TextStyle(
                                color: AppColors.grayColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                        )
                            : ListView.separated(
                            itemBuilder: (_, index) => TaskCard(
                                task: TaskModel.fromString(
                                    controller.allTasks[index]),
                                function: () {
                                  controller.changeToDone(index);
                                }),
                            separatorBuilder: (_, index) => SizedBox(
                              height: 16.h,
                            ),
                            itemCount: controller.allTasks.length);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}