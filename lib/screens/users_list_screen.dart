import 'package:flutter/material.dart';
import 'package:student_list/models/user.dart';
import 'package:student_list/screens/user_edit_screen.dart';
import 'package:student_list/services/api_service.dart';
import 'package:student_list/widgets/user_list_item.dart';

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

  Future<void> loadUsers() async {
    //mounted for check user in this screen or not
    if (!mounted) return; //no get or send data from or to api

    setState(() {
      isLoading = true;
    });
    try {
      users = await apiService.getUsers();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error fetching data: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) {
      //we saw in debug mode : we got api list and after isloading false
      setState(() {
        isLoading = false;
      });
    }
  }

  void _navigateAndRefresh(Widget screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    if (result == true) {
      loadUsers();
      //we dont use await because we dont use it after load
    }
  }

  Future<void> deleteUser(String id) async {
    if (!mounted) return;

    try {
      await apiService.deleteUser(id);
      //why use await? because i have to do sth
      //await loadUsers(); optional
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('delete user successfuly'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting user : $e '),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      floatingActionButton: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              _navigateAndRefresh(UserEditScreen());
            },
            icon: Icon(Icons.add),
            label: Text("Add Student"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'no users found',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to add a new student',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              // pull to refresh
              onRefresh: loadUsers,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text('Student_List'),
                    floating: true,
                    pinned: false,
                    snap: true,
                  ),
                  SliverPadding(
                    padding: EdgeInsetsGeometry.only(
                      bottom: bottomPadding + 100,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final user = users[index];
                        return UserListItem(
                          user: user,
                          onTap: () {
                            _navigateAndRefresh(UserEditScreen(user: user));
                          },
                          onDismissed: () {
                            deleteUser(user.id);
                          },
                        );
                      }, childCount: users.length),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
