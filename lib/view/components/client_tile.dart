import 'package:fit_life/model/client.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ClientTile extends StatelessWidget {
  final ClientModel client;
  final VoidCallback onDelete;

  const ClientTile({super.key, required this.client, required this.onDelete});

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 30),
            SizedBox(width: 10),
            Text("Warning", style: TextStyle(color: Colors.orange)),
          ],
        ),
        content: Text(
          "Deleting the client will remove all sessions associated with them. Are you sure you want to delete ${client.name}?",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete(); // Call delete function
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => _showDeleteConfirmation(context),
              foregroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: ListTile(
              textColor: Colors.white,
              title: Text(
                client.name,
                style: kFont20,
              ),
              trailing: SizedBox(
                width: 200,
                child: Text(
                  DateFormat("d MMM, y").format(client.createdDate),
                  style: kRegularFont.copyWith(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 220, 219, 219),
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
