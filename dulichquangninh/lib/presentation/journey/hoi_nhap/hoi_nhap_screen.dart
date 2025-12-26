import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dulichquangninh/common/constants/image_constants.dart';
import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/journey/hoi_nhap/widgets/list_menu_widget.dart';
import 'package:dulichquangninh/presentation/journey/route/argument_key_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/circular_progress_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/space_widgets/vertical_space_widget.dart';
import 'bloc/hoi_nhap_bloc.dart';

class HoiNhapScreen extends StatefulWidget {
  final ({LoaiDiTichModel menu, List<DiTichModel> list}) khaiQuat;

  const HoiNhapScreen(this.khaiQuat, {super.key});

  @override
  _HoiNhapScreenState createState() => _HoiNhapScreenState();
}

class _HoiNhapScreenState extends State<HoiNhapScreen> {
  final _bloc = locator<HoiNhapBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetHoiNhapData(khaiQuat: widget.khaiQuat));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero_hoi_nhap',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hội nhập & Phát triển'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is HoiNhapFailureState) {
              return _error();
            }
            if (state is HoiNhapLoadedState && state.dacsans.isNotEmpty) {
              return _buildContent(state);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _error() {
    return const Center(
      child: Text('Lỗi'),
    );
  }

  Widget _buildContent(HoiNhapLoadedState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _itemKhaiQuatWidget(widget.khaiQuat.menu, widget.khaiQuat.list),
          _itemDacSanWidget(context, state.dacsans),
        ],
      ),
    );
  }

  Widget _itemKhaiQuatWidget(LoaiDiTichModel menu, List<DiTichModel> list) {
    return Column(
      children: [
        Card3(
          _parentItem(menu.name ?? '', menu.image),
          _buildListKhaiQuat(list),
        ),
        VerticalSpace.init4()
      ],
    );
  }

  Widget _buildListKhaiQuat(List<DiTichModel> khaiQuats) {
    return Column(
        children: List<Widget>.generate(
            khaiQuats.length,
            (index) => _childItem(
                  context: context,
                  images: khaiQuats[index].images ?? [],
                  name: khaiQuats[index].name ?? '',
                  onTap: () {
                    Navigator.pushNamed(
                        context, NamedRouters.diTichDetailScreen, arguments: {
                      ArgKeyConstants.diTichModel: khaiQuats[index]
                    });
                  },
                )));
  }

  Widget _itemDacSanWidget(BuildContext context, List<DacSanModel> dacsans) {
    return Column(
      children: [
        Card3(
          _parentItem('Đặc sản', dacsans.first.images?.first),
          _buildListDacSan(dacsans),
        ),
        VerticalSpace.init4()
      ],
    );
  }

  Widget _buildListDacSan(List<DacSanModel> dacsans) {
    return Column(
        children: List<Widget>.generate(
            dacsans.length,
            (index) => _childItem(
                  context: context,
                  images: dacsans[index].images ?? [],
                  name: dacsans[index].name ?? '',
                  onTap: () {
                    Navigator.pushNamed(
                        context, NamedRouters.dacSanDetailScreen, arguments: {
                      ArgKeyConstants.dacSanModel: dacsans[index]
                    });
                  },
                )));
  }

  Widget _parentItem(String title, String? image) {
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
                      AppCircularProgress(downloadProgress.progress ?? 0),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    .headline6!
                    .copyWith(color: AppColor.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _childItem({
    required BuildContext context,
    required List<String> images,
    required String? name,
    required VoidCallback onTap,
  }) {
    final height = 72.h;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: [
              images!.isEmpty
                  ? Image.asset(
                      ImageConstants.imgSplash,
                      fit: BoxFit.fill,
                      width: ScreenUtil().screenWidth,
                    )
                  : CachedNetworkImage(
                      imageUrl: images[0],
                      progressIndicatorBuilder: (context, url,
                              downloadProgress) =>
                          AppCircularProgress(downloadProgress.progress ?? 0),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                  name ?? '',
                  style: ThemeText.getDefaultTextTheme()
                      .headline6!
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
