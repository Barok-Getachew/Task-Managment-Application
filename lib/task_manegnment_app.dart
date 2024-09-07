import 'package:flutter/material.dart';
import 'utils/app_exports.dart';

class TaskManegnmentApp extends StatelessWidget {
  TaskManegnmentApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      title: 'Task Manager',
      locale: Get.deviceLocale,
      initialRoute: '/splash',
      getPages: AppRoutes.routes,
    );
  }
}
