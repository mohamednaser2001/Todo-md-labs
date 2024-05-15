

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

class ToDoController extends GetxController{

  late SharedPreferences _sharedPreferences;
  late TextEditingController taskController= TextEditingController();

  @override
  void onInit()async {
    _sharedPreferences= await SharedPreferences.getInstance();
    getTask(load: true);
    super.onInit();
  }

  Future<void> saveTask(String taskText)async
  {
    try{
      if (taskText.isNotEmpty) {
        String t = TaskModel(task: taskText, isDone: false)
            .getString();
        allTasks.add(t);
        await _sharedPreferences.setStringList('tasks', allTasks);
        taskController.clear();
        await getTask();
      }
    }catch(e){}
  }


  List<String> allTasks= [];
  int doneTasks= 0;
  bool loadWhileGetTasks= false;
  Future<void> getTask({bool load = false})async
  {
    if(load){
      loadWhileGetTasks= true;
      update(['tasks']);
    }
    try{

      doneTasks= 0;
      allTasks = _sharedPreferences.getStringList('tasks') ?? [];

      allTasks.forEach((element) {
        if(element.split('*_*').last=='true'){
          doneTasks++;
        }
      });
      loadWhileGetTasks= false;
      update(['tasks']);

    }catch(e){
      loadWhileGetTasks= false;
      update(['tasks']);
    }
  }



  changeToDone(int index)async {
    try{
      TaskModel task = TaskModel.fromString(allTasks[index]);
      task.isDone = !task.isDone;
      allTasks[index] = task.getString();
      await _sharedPreferences.setStringList('tasks', allTasks);
      await getTask();
    }catch(e){}
  }
}