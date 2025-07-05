import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastNotification(String color, BuildContext context) {
  Widget toast = Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.green.shade900,
    ),
    child: Text("$color copied to clipboard", style: Theme.of(context).textTheme.bodyLarge,),
  );

  // Fluttertoast.showToast(
  //   msg: "$color copied to clipboard",
  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.TOP,
  //   backgroundColor: Colors.green.shade700,
  //   textColor: Colors.white,
  // );

  FToast().showToast(child: toast, gravity: ToastGravity.TOP);
}
