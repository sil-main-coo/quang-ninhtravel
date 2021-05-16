import 'package:dulichquangninh/common/utils/map_util.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:dulichquangninh/providers/models/loai_luu_tru_model.dart';
import 'package:dulichquangninh/providers/models/luu_tru_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'card_item_widget.dart';

class ListLuuTruWidget extends StatefulWidget {
  final LoaiLuuTruModel loaiLuuTruModel;
  final List<LuuTruModel> luuTrus;

  const ListLuuTruWidget(this.loaiLuuTruModel, this.luuTrus);

  @override
  _ListLuuTruWidgetState createState() => _ListLuuTruWidgetState();
}

class _ListLuuTruWidgetState extends State<ListLuuTruWidget>
    with AutomaticKeepAliveClientMixin {
  void _callPhone(String phone) async {
    final url = 'tel:$phone';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.luuTrus.length,
      itemBuilder: (context, index) => CardItemWidget(
        backWidget: _backWidget(widget.luuTrus[index]),
        frontWidget: _frontWidget(widget.luuTrus[index]),
        iconBack: Icons.contact_phone,
        iconFront: Icons.info,
      ),
      cacheExtent: widget.luuTrus.length.toDouble(),
    );
  }

  Widget _frontWidget(LuuTruModel luuTruModel) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  luuTruModel.name,
                  style: ThemeText.getDefaultTextTheme()
                      .title
                      .copyWith(color: AppColor.primaryColor),
                ),
                Text(
                  'Địa chỉ: ${luuTruModel.address}',
                  style: ThemeText.getDefaultTextTheme().subtitle,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (luuTruModel.roomPrices.singleValue != null)
                        Text(
                          'Phòng đơn: ${luuTruModel.roomPrices.singleValue}đ',
                          style: ThemeText.getDefaultTextTheme()
                              .subtitle
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      if (luuTruModel.roomPrices.doubleValue != null)
                        Text(
                          'Phòng đôi: ${luuTruModel.roomPrices.doubleValue}đ',
                          style: ThemeText.getDefaultTextTheme()
                              .subtitle
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                    ],
                  ),
                ),
                if (luuTruModel.location != null)
                  SizedBox(
                    height: 20.h,
                    child: OutlinedButton.icon(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: AppColor.orange),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      onPressed: () {
                        MapUtil.openMap(luuTruModel.location.lat,
                            luuTruModel.location.long);
                      },
                      icon: Icon(
                        Icons.directions,
                        color: AppColor.orange,
                      ),
                      label: Text(
                        'Chỉ đường',
                        style: ThemeText.getDefaultTextTheme()
                            .button
                            .copyWith(color: AppColor.orange),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _backWidget(LuuTruModel luuTruModel) {
    final bodyStyle = ThemeText.getDefaultTextTheme()
        .subtitle
        .copyWith(fontWeight: FontWeight.normal);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${luuTruModel.contact.position}: ${luuTruModel.contact.fullName}',
            style: ThemeText.getDefaultTextTheme()
                .title
                .copyWith(color: AppColor.primaryDarkColor),
          ),
          VerticalSpace.init8(),
          Row(
            children: [
              Text('SĐT: ', style: bodyStyle),
              _phoneWidget('${luuTruModel.contact.phone[0]}'),
              if (luuTruModel.contact.phone.length > 1)
                Text(' - ', style: bodyStyle),
              if (luuTruModel.contact.phone.length > 1)
                _phoneWidget('${luuTruModel.contact.phone[1]}'),
            ],
          ),
        ]);
  }

  Widget _phoneWidget(String phone) {
    final phoneStyle = ThemeText.getDefaultTextTheme().subtitle.copyWith(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        );

    return InkWell(
        onTap: () => _callPhone(phone),
        child: Text('$phone', style: phoneStyle));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
