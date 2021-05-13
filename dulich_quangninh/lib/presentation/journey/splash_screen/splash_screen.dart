import 'package:dulichquangninh/common/constants/image_constants.dart';
import 'package:dulichquangninh/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:dulichquangninh/presentation/journey/route/argument_key_constants.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:dulichquangninh/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case AppDataLoadedState:
              final typeState = state as AppDataLoadedState;

              Navigator.pushNamedAndRemoveUntil(
                  context, NamedRouters.homeScreen, (route) => false,
                  arguments: {
                    ArgKeyConstants.coverImages: typeState.coverImages,
                    ArgKeyConstants.diTichMap: typeState.mapDiTichs
                  });
              break;
            case AppLoadFailureState:
//                      _navigator.pushAndRemoveUntil<void>(
//                        LoginPage.route(),
//                            (route) => false,
//                      );
              break;
            default:
              break;
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                ImageConstants.imgSplash,
                fit: BoxFit.cover,
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
              ),
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                color: Colors.black.withOpacity(0.3),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đông Triều - Quảng Ninh',
                      style: ThemeText.getDefaultTextTheme()
                          .headline
                          .copyWith(color: AppColor.white),
                    ),
                    VerticalSpace.init8(),
                    CircularProgressIndicator(
                      backgroundColor: AppColor.blue,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
