import 'package:flutter/material.dart';
import 'utils/app_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await dotenv.load(fileName: ".env");
  runApp(TaskManegnmentApp());
}
