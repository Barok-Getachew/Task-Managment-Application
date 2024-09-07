import 'package:flutter/material.dart';
import '../utils/app_exports.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isCompleted = false;

  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(size.height * 0.10), // Set the height of the AppBar
        child: AppBar(
          backgroundColor: ThemeController().isDarkMode.value
              ? Colors.grey
              : const Color.fromARGB(
                  255, 1, 34, 2), // Set the background color to green
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
                  30.0), // Set the radius for the bottom corners
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.06, top: size.height * 0.02),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white, // Change the color of the back button
              onPressed: () {
                Get.back(); // Navigate back to the previous screen
              },
            ),
          ),
          title: Container(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task == null ? 'Add Task' : 'Edit Task',
                  style: const TextStyle(
                    fontSize: 24.0, // Larger font size
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06, vertical: size.height * 0.04),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Title Input
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        focusColor: Color.fromARGB(255, 1, 34, 2),
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        focusColor: Color.fromARGB(255, 1, 34, 2),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Due Date Selector
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      title: const Text('Due Date'),
                      subtitle: Text(DateFormat.yMd().format(_selectedDate)),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          barrierColor: const Color.fromARGB(87, 1, 34, 2),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Completed Switch
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      title: const Text('Completed'),
                      value: _isCompleted,
                      activeColor: const Color.fromARGB(255, 1, 34, 2),
                      onChanged: (value) {
                        setState(() {
                          _isCompleted = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16), // Space between form and button
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.33),
              child: GestureDetector(
                onTap: _saveTask,
                child: Container(
                  padding: EdgeInsets.only(top: size.width * 0.024),
                  width: size.width * 0.61,
                  height: size.height * 0.058,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 1, 34, 2),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 0.04))),
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.width * 0.05),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  @override
  void initState() {
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedDate = widget.task!.dueDate;
      _isCompleted = widget.task!.isCompleted;
    }
    super.initState();
  }

  void _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: widget.task?.id, // Keep the ID if editing
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _selectedDate,
        isCompleted: _isCompleted,
      );
      if (widget.task == null) {
        // Adding new task
        Get.find<TaskController>().addTask(task);
      } else {
        // Editing existing task
        Get.find<TaskController>().updateTask(task);
      }

      Get.back();
    }
  }
}
