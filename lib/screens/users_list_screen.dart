import 'package:flutter/material.dart';
import 'package:student_list/models/user.dart';
import 'package:student_list/services/api_service.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final ApiService apiService = ApiService();
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  loadUsers() async {
    //mounted for check user in this screen or not
    if (!mounted) return; //no get or send data from or to api

    setState(() {
      isLoading = true;
    });
    try {
      users = await apiService.getUsers();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error fetching data: $e")));
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
