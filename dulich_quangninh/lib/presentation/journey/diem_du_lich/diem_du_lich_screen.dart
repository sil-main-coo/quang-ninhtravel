import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/common/utils/map_util.dart';
import 'package:dulichquangninh/presentation/journey/luu_tru/widgets/card_item_widget.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:dulichquangninh/providers/models/diem_du_lich_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/diem_du_lich_bloc.dart';

class DiemDuLichScreen extends StatefulWidget {
  @override
  _DiemDuLichScreenState createState() => _DiemDuLichScreenState();
}

class _DiemDuLichScreenState extends State<DiemDuLichScreen> {
  final _bloc = locator<DiemDuLichBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetDiemDuLichData());
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero1',
      child: Scaffold(
        appBar: AppBar(
          title: Text('Điểm du lịch'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is DiemDuLichFailureState) {
              return _error();
            }
            if (state is DiemDuLichLoadedState) {
              return _bodyTabBar(state.list);
            }

            return Center(
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _error() {
    return Center(
      child: Text('Lỗi'),
    );
  }

  Widget _bodyTabBar(List<DiemDuLichModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) => CardItemWidget(
        backWidget: _backWidget(list[index]),
        frontWidget: _frontWidget(list[index]),
        iconBack: Icons.contact_phone,
        iconFront: Icons.info,
      ),
      cacheExtent: list.length.toDouble(),
    );
  }

  Widget _frontWidget(DiemDuLichModel diem) {
    final priceWidgets = List<Widget>.generate(
        diem.priceList.length,
        (index) => Text(
              '${diem.priceList[index].name}: ${diem.priceList[index].amount}${diem.priceList[index].amount.contains('/') ? '' : 'đ'}',
              style: ThemeText.getDefaultTextTheme()
                  .subtitle
                  .copyWith(fontWeight: FontWeight.normal),
            ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              diem.name,
              style: ThemeText.getDefaultTextTheme()
                  .title
                  .copyWith(color: AppColor.primaryColor),
            ),
            Text(
              'Địa chỉ: ${diem.address}',
              style: ThemeText.getDefaultTextTheme().subtitle,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: priceWidgets),
            ),
            if (diem.location != null)
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
                    MapUtil.openMap(diem.location.lat, diem.location.long);
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
    );
  }

  Widget _backWidget(DiemDuLichModel diem) {
    final bodyStyle = ThemeText.getDefaultTextTheme()
        .subtitle
        .copyWith(fontWeight: FontWeight.normal);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${diem.contact.position}: ${diem.contact.fullName}',
            style: ThemeText.getDefaultTextTheme()
                .title
                .copyWith(color: AppColor.primaryDarkColor),
          ),
          VerticalSpace.init8(),
          Row(
            children: [
              Text('SĐT: ', style: bodyStyle),
              _phoneWidget('${diem.contact.phone[0]}'),
              if (diem.contact.phone.length > 1) Text(' - ', style: bodyStyle),
              if (diem.contact.phone.length > 1)
                _phoneWidget('${diem.contact.phone[1]}'),
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

  void _callPhone(String phone) async {
    final url = 'tel:$phone';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
