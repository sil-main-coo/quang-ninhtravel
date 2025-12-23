import 'package:dulichquangninh/common/constants/icon_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/horizontal_space_widget.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _buttonWidget('hero', IconConstants.icHotel, 'Lưu trú',
                () => Navigator.pushNamed(context, NamedRouters.luuTruScreen),
                size: 64.w),
          ),
          HorizontalSpace(width: 8.w),
          Expanded(
            child: _buttonWidget(
                'hero1',
                IconConstants.icLocation,
                'Điểm du lịch',
                () => Navigator.pushNamed(
                    context, NamedRouters.diemDuLichScreen)),
          ),
          HorizontalSpace(width: 8.w),
          Expanded(
            child: _buttonWidget(
                'hero2',
                IconConstants.icFood,
                'Nông sản - Hoa',
                () => Navigator.pushNamed(context, NamedRouters.dacSanScreen)),
          ),
//          _buttonWidget('hero2', Icons.map, 'Bản đồ', () {}),
        ],
      ),
    );
  }

  Widget _buttonWidget(
      String tag, String iconPath, String text, Function() function,
      {double? size}) {
    return Hero(
      tag: tag,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 4.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                iconPath,
                width: size ?? 48.w,
                height: size ?? 48.w,
              ),
            ),
            VerticalSpace.init4(),
            Text(
              text,
              style: ThemeText.getDefaultTextTheme().bodyText1!.copyWith(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
