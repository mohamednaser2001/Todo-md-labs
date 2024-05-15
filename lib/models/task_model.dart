

class TaskModel{
  String task;
  bool isDone;
  TaskModel({required this.task, required this.isDone});

  factory TaskModel.fromString(String task) {
    List<String> taskFields= task.split('*_*');

    return TaskModel(
        task: taskFields.first,
        isDone: taskFields.last=='true' ? true : false);
  }

  String getString()=> '$task*_*$isDone';
}