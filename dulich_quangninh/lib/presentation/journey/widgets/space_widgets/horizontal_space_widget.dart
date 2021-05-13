import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HorizontalSpace extends StatelessWidget {
  double width;

  HorizontalSpace({this.width});

  HorizontalSpace.init4() : width = 4.w;

  HorizontalSpace.init8() : width = 8.w;

  HorizontalSpace.init16() : width = 16.w;

  HorizontalSpace.init32() : width = 32.w;

  HorizontalSpace.init48() : width = 48.w;

  HorizontalSpace.init64() : width = 64.w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.width,
    );
  }
}
