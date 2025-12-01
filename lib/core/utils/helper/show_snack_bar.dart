import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) {
  _showCustomSnackBar(
    context,
    message,
    icon: Icons.error_outline,
    iconColor: Colors.redAccent,
    backgroundColor: Colors.white,
    textColor: Colors.black,
  );
}

void showSuccessSnackBar(BuildContext context, String message) {
  _showCustomSnackBar(
    context,
    message,
    icon: Icons.check_circle_outline,
    iconColor: Colors.green,
    backgroundColor: Colors.white,
    textColor: Colors.black,
  );
}

void showInfoSnackBar(BuildContext context, String message) {
  _showCustomSnackBar(
    context,
    message,
    icon: Icons.info_outline,
    iconColor: Colors.blueAccent,
    backgroundColor: Colors.white,
    textColor: Colors.black,
  );
}

void _showCustomSnackBar(
  BuildContext context,
  String message, {
  required IconData icon,
  required Color iconColor,
  required Color backgroundColor,
  required Color textColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 5),
      content: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
