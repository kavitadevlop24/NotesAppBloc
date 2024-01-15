import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final Function? onActionTap;

  CustomSnackbar({
    required this.title,
    required this.description,
    required this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Container(
        child: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      action: SnackBarAction(
        label: actionText,
        textColor: Colors.yellow,
        onPressed: () {
          if (onActionTap != null) {
            onActionTap!();
          }
        },
      ),
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 3),
    );
  }
}