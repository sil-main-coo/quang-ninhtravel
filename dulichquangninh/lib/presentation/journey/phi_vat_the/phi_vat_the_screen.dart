import 'package:cached_network_image/cached_network_image.dart';
import 'package:dulichquangninh/common/constants/image_constants.dart';
import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/journey/phi_vat_the/bloc/phi_vat_the_bloc.dart';
import 'package:dulichquangninh/presentation/journey/route/argument_key_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/circular_progress_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:dulichquangninh/providers/models/phi_vat_the_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhiVatTheScreen extends StatefulWidget {
  @override
  _PhiVatTheScreenState createState() => _PhiVatTheScreenState();
}

class _PhiVatTheScreenState extends State<PhiVatTheScreen> {
  final _bloc = locator<PhiVatTheBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(const GetPhiVatTheData());
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero_phi_vat_the',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Văn hoá phi vật thể'),
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
            if (state is PhiVatTheFailureState) {
              return _error();
            }
            if (state is PhiVatTheLoadedState) {
              return _buildList(state.phiVatThes);
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

  Widget _buildList(List<PhiVatTheModel> phiVatThes) {
    return ListView.builder(
        itemCount: phiVatThes.length,
        itemBuilder: (ct, index) => _childItem(context, phiVatThes[index]));
  }

  Widget _childItem(BuildContext context, PhiVatTheModel phiVatThe) {
    final height = 72.h;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, NamedRouters.dacSanDetailScreen,
          arguments: {ArgKeyConstants.dacSanModel: phiVatThe}),
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: [
              phiVatThe.images!.isEmpty
                  ? Image.asset(
                      ImageConstants.imgSplash,
                      fit: BoxFit.fill,
                      width: ScreenUtil().screenWidth,
                    )
                  : CachedNetworkImage(
                      imageUrl: phiVatThe.images![0],
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
                  phiVatThe.name ?? '',
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
