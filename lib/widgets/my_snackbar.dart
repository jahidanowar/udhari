import 'package:flutter/material.dart';

enum SnakbarType { success, error, info }

class MySnackbar {
  static void showSnackbar(
      {required BuildContext context,
      required String message,
      required SnakbarType type,
      Duration? duration,
      String? actionText,
      Function? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: _getBackgroundColor(type),
        duration: duration ?? const Duration(seconds: 3),
        action: action != null && actionText != null
            ? SnackBarAction(
                label: actionText,
                onPressed: () => action(),
              )
            : null,
      ),
    );
  }

  static _getBackgroundColor(SnakbarType type) {
    switch (type) {
      case SnakbarType.success:
        return Colors.green;
      case SnakbarType.error:
        return Colors.red;
      case SnakbarType.info:
        return Colors.blue;
    }
  }
}
