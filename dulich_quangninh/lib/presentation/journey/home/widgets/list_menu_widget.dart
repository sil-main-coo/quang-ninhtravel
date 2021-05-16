import 'package:cached_network_image/cached_network_image.dart';
import 'package:dulichquangninh/common/constants/image_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/argument_key_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/circular_progress_widget.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:expandable/expandable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ListMenuHomeWidget extends StatelessWidget {
  final Map<LoaiDiTichModel, List<DiTichModel>> mapDiTichs;
  List<LoaiDiTichModel> loaiDiTichs = [];

  ListMenuHomeWidget(this.mapDiTichs) {
    this.loaiDiTichs = mapDiTichs.keys.toList();

    // đưa khai quat lên đầu
    final indexIntro =
        loaiDiTichs.indexWhere((element) => element.tag == 'khai-quat');
    this.loaiDiTichs.insert(0, loaiDiTichs[indexIntro]);
    this.loaiDiTichs.removeAt(indexIntro + 1);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: loaiDiTichs.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) => _itemWidget(
            context, loaiDiTichs[index], mapDiTichs[loaiDiTichs[index]]));

//    return _test();
  }

  Widget _itemWidget(BuildContext context, LoaiDiTichModel loaiDiTich,
      List<DiTichModel> diTichs) {
    return Column(
      children: [
        Card3(_parentItem(loaiDiTich.name, loaiDiTich.image),
            _buildList(context, diTichs)),
        VerticalSpace.init4()
      ],
    );
  }

  Widget _buildList(BuildContext context, List<DiTichModel> diTichs) {
    return Column(
      children: List<Widget>.generate(
          diTichs.length, (index) => _childItem(context, diTichs[index])),
    );
  }

  Widget _parentItem(String title, String image) {
    final height = 100.h;
    final heightTitle = 25.h;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          image == null
              ? Image.asset(
                  ImageConstants.imgSplash,
                  fit: BoxFit.fill,
                  width: ScreenUtil().screenWidth,
                )
              : CachedNetworkImage(
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      AppCircularProgress(downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                  width: ScreenUtil().screenWidth,
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColor.blue.withOpacity(0.8),
              alignment: Alignment.center,
              height: heightTitle,
              child: Text(
                title,
                style: ThemeText.getDefaultTextTheme()
                    .title
                    .copyWith(color: AppColor.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _childItem(BuildContext context, DiTichModel diTich) {
    final height = 85.h;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, NamedRouters.diTichDetailScreen,
          arguments: {ArgKeyConstants.diTichModel: diTich}),
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: [
              diTich.images.isEmpty
                  ? Image.asset(
                      ImageConstants.imgSplash,
                      fit: BoxFit.fill,
                      width: ScreenUtil().screenWidth,
                    )
                  : CachedNetworkImage(
                      imageUrl: diTich.images[0],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              AppCircularProgress(downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                      width: ScreenUtil().screenWidth,
                    ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.4),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  diTich.name,
                  style: ThemeText.getDefaultTextTheme()
                      .title
                      .copyWith(color: AppColor.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Card3 extends StatelessWidget {
  final Widget header;
  final Widget expanded;

  Card3(this.header, this.expanded);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ExpandableNotifier(
          child: ScrollOnExpand(
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToExpand: false,
            tapBodyToCollapse: false,
            hasIcon: false,
          ),
          header: header,
          collapsed: Container(),
          expanded: expanded,
        ),
      )),
    );
  }
}
