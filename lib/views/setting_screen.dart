import 'package:flutter/material.dart';
import '../utils/app_exports.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.10),
        child: AppBar(
          backgroundColor: themeController.isDarkMode.value
              ? Colors.grey
              : const Color.fromARGB(255, 1, 34, 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.06, top: size.height * 0.02),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          title: Container(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
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
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.06,
          ),
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Obx(() => Switch(
                  value: themeController.isDarkMode.value,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                )),
          ),
        ],
      ),
    );
  }
}
