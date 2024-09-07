import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagnent/controller/task_controller.dart';
import 'package:taskmanagnent/controller/theme_controller.dart';
import 'package:taskmanagnent/models/task.dart';
import 'package:taskmanagnent/views/add_edit_screen.dart';
import 'package:taskmanagnent/views/home_screen.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final Size size;
  final ThemeController themeController;

  TaskTile(
      {required this.task, required this.size, required this.themeController});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isExpanded = false;
  TaskController taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded; // Toggle the expanded state
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        padding: EdgeInsets.symmetric(
            vertical: widget.size.height * 0.025,
            horizontal: widget.size.width * 0.06),
        margin: EdgeInsets.symmetric(
            vertical: 8, horizontal: widget.size.width * 0.01),
        decoration: BoxDecoration(
          color: widget.themeController.isDarkMode.value
              ? Colors.grey
              : Color.fromARGB(86, 130, 225, 113),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.task_alt_rounded,
                  size: widget.size.width * 0.1,
                ),
                SizedBox(
                  width: widget.size.width * 0.03,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${widget.task.dueDate.toLocal()}'.split(' ')[0],
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.task.isCompleted ? 'Completed' : 'Ongoing',
                  style: TextStyle(
                    color: widget.task.isCompleted ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
            if (isExpanded) ...[
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: Text(
                  widget.task.description,
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: Row(
                  children: [
                    const Text(
                      'Due Date: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${widget.task.dueDate.toLocal()}'.split(' ')[0],
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    label: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      // Navigate to the TaskFormScreen with the current task for editing
                      Get.to(TaskFormScreen(task: widget.task),
                          transition: Transition.fadeIn);
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
