import 'package:get/get.dart';
import '../views/splash_screen.dart';
import '../views/home_screen.dart';
import '../views/add_edit_screen.dart';
import '../views/completed_task.dart';
import '../views/setting_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/add_task',
      page: () => TaskFormScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/completed_tasks',
      page: () => const CompletedTasksScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/settings',
      page: () => SettingsScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
