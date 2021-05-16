import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buttonWidget('hero', Icons.single_bed, 'Lưu trú',
              () => Navigator.pushNamed(context, NamedRouters.luuTruScreen)),
          _buttonWidget(
              'hero1',
              Icons.location_on,
              'Điểm du lịch',
              () =>
                  Navigator.pushNamed(context, NamedRouters.diemDuLichScreen)),
//          _buttonWidget('hero2', Icons.map, 'Bản đồ', () {}),
        ],
      ),
    );
  }

  Widget _buttonWidget(
      String tag, IconData iconData, String text, Function function) {
    return Hero(
      tag: tag,
      child: RaisedButton(
        onPressed: function,
        color: AppColor.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: AppColor.primaryColor,
            ),
            VerticalSpace.init4(),
            Text(
              text,
              style: ThemeText.getDefaultTextTheme().body2,
            ),
          ],
        ),
      ),
    );
  }
}
