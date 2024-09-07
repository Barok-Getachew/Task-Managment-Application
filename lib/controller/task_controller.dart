import 'package:get/get.dart';
import '../models/task.dart';
import '../services/notfication_service.dart';
import '../services/storage_service.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    var taskList = await StorageService.getTasks();
    tasks.clear();
    tasks.assignAll(taskList);
  }

  void addTask(Task task) async {
    await StorageService.saveTask(task);

    DateTime scheduleTime = task.dueDate.subtract(const Duration(seconds: 1));

    if (scheduleTime.isAfter(DateTime.now())) {
      await NotificationService().scheduleNotification(
        id: task.id!,
        title: 'Task Reminder',
        body: 'Your task "${task.title}" is due soon!',
        scheduledDate: scheduleTime,
      );
    }

    fetchTasks();
  }

  void updateTask(Task task) async {
    await StorageService.updateTask(task);

    fetchTasks();
  }
}
