import 'package:flutter/material.dart';
import 'screens/importAll.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: LoadingScreen.route, routes: {
      LoadingScreen.route: (context) => LoadingScreen(),
      TaskScreen.route: (context) => TaskScreen(),
      AddTaskScreen.route: (context) => AddTaskScreen(),
      HealthTaskScreen.route: (context) => HealthTaskScreen(),
      AddWorkTaskScreen.route: (context) => AddWorkTaskScreen(),
    });
  }
}
