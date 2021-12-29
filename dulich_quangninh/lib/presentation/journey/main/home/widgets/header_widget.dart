import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/circular_progress_widget.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderHomeWidget extends StatefulWidget {
  HeaderHomeWidget(this.coverImages);

  final List<String> coverImages;

  @override
  _HeaderHomeWidgetState createState() => _HeaderHomeWidgetState();
}

class _HeaderHomeWidgetState extends State<HeaderHomeWidget>
    with AutomaticKeepAliveClientMixin {
  List<Widget> imageSliders;

  @override
  void initState() {
    // TODO: implement initState
    imageSliders = widget.coverImages
        .map((item) => CachedNetworkImage(
            imageUrl: item,
            progressIndicatorBuilder:
                (context, url, downloadProgress) =>
                    AppCircularProgress(downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: 1000.0.w))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final slideWidget = ImageSlideshow(
      children: imageSliders,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      autoPlayInterval: 5000,
    );
    return Column(children: [
      slideWidget,
      VerticalSpace.init8(),
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
