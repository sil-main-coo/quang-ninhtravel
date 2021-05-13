import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class VerticalSpace extends StatelessWidget {
  double height;

  VerticalSpace({this.height});

  VerticalSpace.init4() : height = 4.h;

  VerticalSpace.init8() : height = 8.h;

  VerticalSpace.init16() : height = 16.h;

  VerticalSpace.init32() : height = 32.h;

  VerticalSpace.init48() : height = 48.h;

  VerticalSpace.init64() : height = 64.h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
    );
  }
}
