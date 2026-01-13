import 'package:flutter/material.dart';

class AppSnackbar {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void _show(
    String title,
    String message, {
    required Color backgroundColor,
    IconData icon = Icons.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      duration: duration,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(message, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );

    messengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void success({String title = 'Success', required String message}) {
    _show(
      title,
      message,
      backgroundColor: Colors.green.shade600,
      icon: Icons.check_circle,
    );
  }

  static void error({String title = 'Error', required String message}) {
    _show(
      title,
      message,
      backgroundColor: Colors.red.shade600,
      icon: Icons.error,
      duration: const Duration(seconds: 4),
    );
  }

  static void warning({String title = 'Warning', required String message}) {
    _show(
      title,
      message,
      backgroundColor: Colors.orange.shade600,
      icon: Icons.warning,
    );
  }

  static void info({String title = 'Info', required String message}) {
    _show(
      title,
      message,
      backgroundColor: Colors.blue.shade600,
      icon: Icons.info,
    );
  }

  static void custom({
    String title = 'Info',
    required String message,
    required Color backgroundColor,
    IconData icon = Icons.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      title,
      message,
      backgroundColor: backgroundColor,
      icon: icon,
      duration: duration,
    );
  }
}
