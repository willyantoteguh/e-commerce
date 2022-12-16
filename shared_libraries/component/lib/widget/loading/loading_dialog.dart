import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context) async {
    // show the loading dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CustomCircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Loading...')
                ],
              ),
            ),
          );
        });
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
