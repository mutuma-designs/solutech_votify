import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

extension SnackBarContext on BuildContext {
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(message),
      ),
    );
  }

  void showLoadingDialog(String message) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 10),
            Text(message),
          ],
        ),
      ),
    );
  }

  Future<void> showAlert({
    required String title,
    required String message,
  }) {
    return showDialog<void>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showConfirm({
    required String title,
    String? message,
    String confirmText = 'OK',
  }) async {
    bool? result = await showDialog<bool>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                pop(false);
              },
            ),
            TextButton(
              child: Text(confirmText.toUpperCase()),
              onPressed: () {
                pop(true);
              },
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  Future<dynamic> showModal({
    required String title,
    bool isDismissible = true,
    required Widget child,
  }) =>
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: isDismissible,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) => Container(
          padding: const EdgeInsets.all(20)
              .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Close button
                const Spacer(),
                IconButton(
                  onPressed: () {
                    pop();
                  },
                  icon: const Icon(FeatherIcons.x),
                ),
              ]),
              child
            ],
          ),
        ),
        context: this,
      );
}
