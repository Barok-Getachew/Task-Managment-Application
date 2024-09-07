import 'package:flutter/material.dart';
import '../utils/app_exports.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final ThemeController themeController = Get.put(ThemeController());

  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.5),
        child: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.06, top: size.height * 0.028),
            child: IconButton(
              icon: const Icon(Icons.menu),
              color: const Color.fromARGB(255, 255, 255,
                  255), // Change the color of the hamburger button
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: size.height * 0.04),
            child: const Text(
              'Task Manager',
              style: TextStyle(
                fontSize: 24.0, // Larger font size
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: themeController.isDarkMode.value
              ? Colors.grey
              : const Color.fromARGB(255, 1, 34, 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0),
            ),
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Do you want to manage yourself? Click \n to add more tasks efficiently',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2, // Limit to 2 lines
                      overflow: TextOverflow
                          .ellipsis, // Add an ellipsis (...) if the text overflows
                    ),
                    FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: themeController.isDarkMode.value
                          ? const Color.fromARGB(255, 47, 43, 43)
                          : Colors.amber,
                      onPressed: () => Get.toNamed('/add_task'),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                FutureBuilder(
                  future: QuoteService
                      .fetchRandomQuote(), // Fetch the quote from the API
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LinearProgressIndicator(
                        color: Color.fromARGB(255, 15, 81, 17),
                      );
                    } else if (snapshot.hasError) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Failed to load quote'),
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.01),
                        height: size.height * 0.21,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.04)),
                          color: const Color.fromARGB(115, 36, 52, 37),
                        ),
                        child: Center(
                          child: Text(
                            '"${snapshot.data}"',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 255, 239, 239),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: themeController.isDarkMode.value
                    ? Colors.grey
                    : const Color.fromARGB(255, 1, 34, 2),
              ),
              child: Icon(
                Icons.task,
                color: Colors.white,
                size: size.height * 0.08,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Completed Tasks'),
              onTap: () {
                // Navigate to Completed Tasks screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Get.toNamed('/settings');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.03),
              child: Text(
                'Task Manager',
                style: TextStyle(
                  fontSize: 24.0, // Larger font size
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : const Color.fromARGB(255, 1, 34, 2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Obx(() => taskController.tasks.isEmpty
                  ? const Center(
                      child: Text('No tasks available'),
                    )
                  : Obx(
                      () => ListView.builder(
                        itemCount: taskController.tasks.length,
                        itemBuilder: (context, index) {
                          var task = taskController.tasks[index];
                          return TaskTile(
                            themeController: themeController,
                            task: task,
                            size: size,
                          );
                        },
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
