import 'package:dulichquangninh/common/constants/icon_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/argument_key_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/horizontal_space_widget.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonHomeWidget extends StatelessWidget {
  final Map<LoaiDiTichModel, List<DiTichModel>> mapDiTichs;
  final ({LoaiDiTichModel menu, List<DiTichModel> list}) khaiQuat;

  const ButtonHomeWidget(this.mapDiTichs, this.khaiQuat);

  @override
  Widget build(BuildContext context) {
    return GridView(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 1,
      ),
      children: [
        _buttonWidget(
          'hero_hoi_nhap',
          IconConstants.icHotel,
          'Hội nhập và phát triển',
          () => Navigator.pushNamed(context, NamedRouters.hoiNhap,
              arguments: {ArgKeyConstants.khaiQuat: khaiQuat}),
        ),
        _buttonWidget(
            'hero_diem_den',
            IconConstants.icLocation,
            'Điểm đến - Nghỉ dưỡng',
            () => Navigator.pushNamed(context, NamedRouters.luuTruScreen)),
        _buttonWidget(
            'hero_vat_the',
            IconConstants.icHotel,
            'Văn hoá vật thể',
            () => Navigator.pushNamed(context, NamedRouters.vatThe,
                arguments: {ArgKeyConstants.diTichMap: mapDiTichs})),
        _buttonWidget(
            'hero_phi_vat_the',
            IconConstants.icFood,
            'Văn hoá phi vật thể',
            () => Navigator.pushNamed(context, NamedRouters.phiVatThe)),
        // _buttonWidget('hero', IconConstants.icHotel, 'Lưu trú',
        //     () => Navigator.pushNamed(context, NamedRouters.luuTruScreen),
        //     size: 64.w),
        // _buttonWidget(
        //     'hero1',
        //     IconConstants.icLocation,
        //     'Điểm du lịch',
        //     () => Navigator.pushNamed(
        //         context, NamedRouters.diemDuLichScreen)),
        // _buttonWidget(
        //     'hero2',
        //     IconConstants.icFood,
        //     'Nông sản - Hoa',
        //     () => Navigator.pushNamed(context, NamedRouters.dacSanScreen)),
        // _buttonWidget(
        //     'hero2',
        //     IconConstants.icFood,
        //     'Nông sản - Hoa',
        //         () => Navigator.pushNamed(context, NamedRouters.dacSanScreen)),
        //          _buttonWidget('hero2', Icons.map, 'Bản đồ', () {}),
      ],
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
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                iconPath,
                width: size ?? 90.w,
                height: size ?? 90.w,
              ),
            ),
            VerticalSpace.init4(),
            Text(
              text,
              style: ThemeText.getDefaultTextTheme().bodyText1!.copyWith(
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 26.sp,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
