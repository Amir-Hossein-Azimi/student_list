import 'package:flutter/material.dart';
import 'package:student_list/models/user.dart';

class UserListItem extends StatelessWidget {
  //add delete and add ...
  final User user;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const UserListItem({
    super.key,
    required this.user,
    required this.onTap,
    required this.onDismissed,
  });

  Color _getAvatarColor(String id) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];
    final hashCode = id.hashCode;
    final index = hashCode % colors.length;
    return colors[index].shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(user.id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete_sweep, color: Colors.white, size: 30),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirm Deletation'),
              content: Text('Are you sure you want to delete ${user.name}?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red.shade400),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: _getAvatarColor(user.id),
            child: Text(
              user.name.isNotEmpty ? user.name[0].toUpperCase() : '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            user.city,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          onTap: onTap,
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
