

import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteTile({
    required this.title,
    required this.content,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: const Color.fromARGB(255, 247, 237, 222), // light beige background for contrast
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: onView,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 18, 11, 3)), // dark brown for title
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color.fromARGB(255, 104, 86, 52), fontSize: 14), // medium brown for subtitle
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete), 
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
