import 'package:dulichquangninh/common/constants/icon_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buttonWidget('hero', IconConstants.icHotel, 'Lưu trú',
              () => Navigator.pushNamed(context, NamedRouters.luuTruScreen),
              size: 64.w),
          _buttonWidget(
              'hero1',
              IconConstants.icLocation,
              'Điểm du lịch',
              () =>
                  Navigator.pushNamed(context, NamedRouters.diemDuLichScreen)),
          _buttonWidget('hero2', IconConstants.icFood, 'Đặc sản',
              () => Navigator.pushNamed(context, NamedRouters.dacSanScreen)),
//          _buttonWidget('hero2', Icons.map, 'Bản đồ', () {}),
        ],
      ),
    );
  }

  Widget _buttonWidget(
      String tag, String iconPath, String text, Function function,
      {double size}) {
    return Hero(
      tag: tag,
      child: RaisedButton(
        onPressed: function,
        color: AppColor.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: size ?? 48.w,
              height: size ?? 48.w,
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
