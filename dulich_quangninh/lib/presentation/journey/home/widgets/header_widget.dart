import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/circular_progress_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderHomeWidget extends StatefulWidget {
  HeaderHomeWidget(this.coverImages);

  final List<String> coverImages;

  @override
  _HeaderHomeWidgetState createState() => _HeaderHomeWidgetState();
}

class _HeaderHomeWidgetState extends State<HeaderHomeWidget>
    with AutomaticKeepAliveClientMixin {
  int _current = 0;
  List<Widget> imageSliders;

  @override
  void initState() {
    // TODO: implement initState
    imageSliders = widget.coverImages
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: CachedNetworkImage(
                        imageUrl: item,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                AppCircularProgress(downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: 1000.0.w)),
              ),
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final slideWidget = CarouselSlider(
      items: imageSliders,
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
    final circlePoints = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.coverImages.map((url) {
        int index = widget.coverImages.indexOf(url);
        return Container(
          width: 16.w,
          height: 16.h,
          margin: EdgeInsets.symmetric(horizontal: 4.0.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index
                ? AppColor.primaryColor
                : Color.fromRGBO(0, 0, 0, 0.4),
          ),
        );
      }).toList(),
    );
    return Column(children: [
      slideWidget,
      circlePoints,
      Text('Đông Triều - Quảng Ninh',
          style: ThemeText.getDefaultTextTheme()
              .headline
              .copyWith(color: AppColor.primaryColor))
    ]);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
