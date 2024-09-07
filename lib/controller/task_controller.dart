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

    var tasks = await StorageService.getTasks();
    var savedTask = tasks.firstWhere(
        (t) => t.title == task.title && t.description == task.description);

    await NotificationService().showNotfication(task: savedTask);

    // Refresh the task list
    fetchTasks();
  }

  void updateTask(Task task) async {
    await StorageService.updateTask(task);

    fetchTasks();
  }
}
