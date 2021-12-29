import 'package:flutter/material.dart';

class AppLoaderDialog {
  BuildContext _context;

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (thisContext) {
          _context = thisContext;
          return Center(
            child: SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator()),
          );
        });
  }

  void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
