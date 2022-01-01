import 'package:cached_network_image/cached_network_image.dart';
import 'package:dulichquangninh/common/constants/image_constants.dart';
import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/journey/route/argument_key_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/circular_progress_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc/dac_san_bloc.dart';

class DacSanScreen extends StatefulWidget {
  @override
  _DacSanScreenState createState() => _DacSanScreenState();
}

class _DacSanScreenState extends State<DacSanScreen> {
  final _bloc = locator<DacSanBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetDacSanData());
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero2',
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đặc sản ẩm thực'),
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
            if (state is DacSanFailureState) {
              return _error();
            }
            if (state is DacSanLoadedState) {
              return _buildListDacSan(state.dacsans);
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

  Widget _buildListDacSan(List<DacSanModel> dacsans) {
    return ListView.builder(
        itemCount: dacsans.length,
        itemBuilder: (ct, index) => _childItem(context, dacsans[index]));
  }

  Widget _childItem(BuildContext context, DacSanModel dacSan) {
    final height = 72.h;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, NamedRouters.dacSanDetailScreen,
          arguments: {ArgKeyConstants.dacSanModel: dacSan}),
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: [
              dacSan.images.isEmpty
                  ? Image.asset(
                      ImageConstants.imgSplash,
                      fit: BoxFit.fill,
                      width: ScreenUtil().screenWidth,
                    )
                  : CachedNetworkImage(
                      imageUrl: dacSan.images[0],
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
                  dacSan.name,
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
