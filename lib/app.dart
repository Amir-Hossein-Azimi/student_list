import 'package:flutter/material.dart';
import 'package:student_list/screens/users_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Student List 🎓",
      debugShowCheckedModeBanner: false,
      home: const UsersListScreen(),
    );
  }
}