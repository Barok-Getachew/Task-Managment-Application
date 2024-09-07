import 'package:flutter/material.dart';
import 'utils/app_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(TaskManegnmentApp());
}
