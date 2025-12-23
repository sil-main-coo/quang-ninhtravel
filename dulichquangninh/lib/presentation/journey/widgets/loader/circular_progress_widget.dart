import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCircularProgress extends StatelessWidget {
  final double progress;

  AppCircularProgress(this.progress);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 32.w,
        width: 32.w,
        child: CircularProgressIndicator(value: progress),
      ),
    );
  }
}
